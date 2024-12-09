//
//  ChickenViewModel.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 05/12/24.
//

import Foundation
import UIKit

internal class ChickenViewModel {
    var chicken: Chicken
    var onImageLoaded: ((UIImage?) -> Void)?
    
    init(chicken: Chicken) {
        self.chicken = chicken
        self.loadImage()
    }
    
    private func loadImage() {
        DispatchQueue.global().async { [weak self] in
            if let imageUrl = URL(string: self?.chicken.menuImage ?? ""),
               let imageData = try? Data(contentsOf: imageUrl),
               let image = UIImage(data: imageData) {
                self?.onImageLoaded?(image)
            }
        }
    }
}
