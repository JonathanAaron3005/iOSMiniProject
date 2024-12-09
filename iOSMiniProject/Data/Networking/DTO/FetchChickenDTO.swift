//
//  FetchChickenDTO.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 05/12/24.
//

import Foundation

internal struct FetchChickenDTO: Encodable {
    let searchParams: String?
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        if let searchParams {
            dictionary["s"] = searchParams
        }
        
        return dictionary
    }
}
