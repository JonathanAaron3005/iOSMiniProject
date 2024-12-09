//
//  ViewController.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 03/12/24.
//

import Combine
import UIKit

class HomeViewController: UIViewController {
    
    private var viewmodel = HomeViewModel()
    private var cancellables = Set<AnyCancellable>()
    
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
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func setupBindings() {
        viewmodel.$chickens
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                print("sink called")
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewmodel.chickens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell
        else {
            fatalError("Unable to dequeue CustomCell in HomeViewController")
        }
        
        let chicken = viewmodel.chickens[indexPath.item]
        cell.configure(with: chicken)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width 
        let itemWidth = availableWidth / 2 - 8
        return CGSize(width: itemWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        let chicken = viewmodel.chickens[indexPath.item]
        let vm = ChickenViewModel(chicken: chicken)
        self.navigationController?.pushViewController(ChickenViewController(viewModel: vm), animated: true)
    }
}

