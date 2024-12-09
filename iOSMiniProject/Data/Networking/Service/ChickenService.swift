//
//  ChickenService.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 05/12/24.
//

import Foundation

internal class ChickenService {
    static let shared = ChickenService()
    
    func fetchChickens(param: FetchChickenDTO) -> Endpoint {
        return FetchChickenEndpoint(param: param)
    }
}

struct FetchChickenEndpoint: Endpoint {
    let param: FetchChickenDTO
    
    var baseURL: URL {
        URL(string: APIConstant.baseUrl)!
    }
    
    var path: String {
        "/v1/1/search.php"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : String]? {
        [
            "Content-Type": "application/json",
        ]
    }
    
    var parameters: [String : Any]? {
        return param.toDictionary()
    }
    
    var body: Data?
}
