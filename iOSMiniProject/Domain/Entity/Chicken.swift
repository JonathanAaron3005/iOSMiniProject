//
//  File.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 03/12/24.
//

import Foundation

class Chicken: Hashable {
    var id = UUID()
    let menuName: String
    let menuImage: String
    let menuArea: String
    let strIngredient1: String
    let strIngredient2: String
    let strMeasure1: String
    let strMeasure2: String
    
    init(id: UUID = UUID(), menuName: String, menuImage: String, menuArea: String, strIngredient1: String, strIngredient2: String, strMeasure1: String, strMeasure2: String) {
        self.id = id
        self.menuName = menuName
        self.menuImage = menuImage
        self.menuArea = menuArea
        self.strIngredient1 = strIngredient1
        self.strIngredient2 = strIngredient2
        self.strMeasure1 = strMeasure1
        self.strMeasure2 = strMeasure2
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Chicken, rhs: Chicken) -> Bool {
        lhs.id == rhs.id
    }
}

