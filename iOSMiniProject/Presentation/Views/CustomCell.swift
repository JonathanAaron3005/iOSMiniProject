//
//  CustomCellTableViewCell.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 03/12/24.
//

import UIKit
import Foundation
import SDWebImage

class CustomCell: UICollectionViewCell {

    static let identifier = "CustomCell"
    
    private var chicken: Chicken!
    
    private let testLogo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .black
        
        return iv
    }()
    
    private let testLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.textColor = .label
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with chicken: Chicken) {
        self.chicken = chicken
        self.testLabel.text = chicken.menuName
        
        guard let imageUrl = URL(string: self.chicken.menuImage) else {
            fatalError("cant get image URL")
        }
        
        self.testLogo.sd_setImage(with: imageUrl)
    }
    
    private func setupUI() {
        self.addSubview(testLogo)
        self.addSubview(testLabel)
        
        testLogo.translatesAutoresizingMaskIntoConstraints = false
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            testLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            testLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            testLogo.widthAnchor.constraint(equalTo: self.widthAnchor),
            testLogo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            testLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            testLabel.topAnchor.constraint(equalTo: testLogo.bottomAnchor, constant: 8)
        ])
    }

}
