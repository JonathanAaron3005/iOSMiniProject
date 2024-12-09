//
//  FetchChickenResponseDTO.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 05/12/24.
//

import Foundation

internal struct FetchChickenResponseDTO: Decodable {
    let meals: [FetchChickenResponseData]
}

internal struct FetchChickenResponseData: Decodable {
    let strMealThumb: String
    let strMeal: String
    let strArea: String
    let strIngredient1: String
    let strIngredient2: String
    let strMeasure1: String
    let strMeasure2: String
}

internal extension FetchChickenResponseDTO {
    func toDomain() -> [Chicken] {
        return meals.map { meal in
            return .init(menuName: meal.strMeal, menuImage: meal.strMealThumb, menuArea: meal.strArea, strIngredient1: meal.strIngredient1, strIngredient2: meal.strIngredient2, strMeasure1: meal.strMeasure1, strMeasure2: meal.strMeasure2)
        }
    }
}
