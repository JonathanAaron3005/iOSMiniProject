//
//  ViewController.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 03/12/24.
//

import Combine
import UIKit

class HomeViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    private var viewmodel = HomeViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Chicken>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Chicken>
    
    private lazy var dataSource = makeDataSource()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupBindings()
        self.setupSearchController()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = dataSource
        
        self.applySnapshot()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Choose Your Menu"
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Chicken Menu"
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
    }
    
    private func setupBindings() {
        viewmodel.$filteredChickens
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapshot()
            }
            .store(in: &cancellables)
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewmodel.filteredChickens)
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) ->
            UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell
            else {
                fatalError("Unable to dequeue CustomCell in HomeViewController")
            }
            
            let chicken = self.viewmodel.filteredChickens[indexPath.item]
            cell.configure(with: chicken)
            
            return cell
        })
        
        return dataSource
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        viewmodel.filterChickens(by: searchText)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width
        let itemWidth = availableWidth / 2 - 8
        return CGSize(width: itemWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        let chicken = viewmodel.filteredChickens[indexPath.item]
        let vm = ChickenViewModel(chicken: chicken)
        self.navigationController?.pushViewController(ChickenViewController(viewModel: vm), animated: true)
    }
}

