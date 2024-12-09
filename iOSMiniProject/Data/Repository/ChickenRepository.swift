//
//  ChickenRepository.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 06/12/24.
//

import Foundation

internal protocol ChickenRepository {
    func fetchChicken(param: FetchChickenDTO) async throws -> FetchChickenResponseDTO
}

internal class ChickenRepositoryImpl: ChickenRepository {
    let service = ChickenService.shared
    let networkManager = NetworkManager.shared
    
    func fetchChicken(param: FetchChickenDTO) async throws -> FetchChickenResponseDTO {
        let endpoint = service.fetchChickens(param: param)
        let res: FetchChickenResponseDTO = try await networkManager.fetch(from: endpoint)
        
        return res
    }
}
