//
//  ChickenViewController.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 05/12/24.
//

import UIKit

class ChickenViewController: UIViewController {

    private var viewModel: ChickenViewModel
    
    private let contentView: UIView = {
        let contentView = UIView()
        
        return contentView
    }()
    
    private let menuImage: UIImageView = {
        var menuImage = UIImageView()
        menuImage.contentMode = .scaleAspectFit
        menuImage.image = UIImage(systemName: "questionmark")
        menuImage.tintColor = .black
        menuImage.backgroundColor = .systemGray
        
        return menuImage
    }()
    
    private let menuName: UILabel = {
        var menuName = UILabel()
        menuName.text = "error"
        menuName.font = .systemFont(ofSize: 20, weight: .medium)
        
        return menuName
    }()
    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [menuName])
        vStack.axis = .vertical
        vStack.spacing = 12
        vStack.alignment = .leading
        
        return vStack
    }()
    
    init(viewModel: ChickenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.setUpUI()
        
        self.menuName.text = self.viewModel.chicken.menuName
        self.viewModel.onImageLoaded = { [weak self] menuImage in
            DispatchQueue.main.async {
                self?.menuImage.image = menuImage
            }
        }
        self.navigationItem.title = self.menuName.text
    }
    
    private func setUpUI() {
        self.view.addSubview(contentView)
        self.contentView.addSubview(menuImage)
        self.contentView.addSubview(vStack)
        self.view.backgroundColor = .systemBackground
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        menuImage.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            menuImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            menuImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            menuImage.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.4),
            menuImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            
            vStack.topAnchor.constraint(equalTo: self.menuImage.bottomAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
            vStack.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor),
            vStack.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: 10),
        ])
    }
}
