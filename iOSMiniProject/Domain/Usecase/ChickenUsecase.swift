//
//  ChickenUsecase.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 06/12/24.
//

import Foundation

internal protocol ChickenUsecase {
    func fetchChicken(search: String) async throws -> [Chicken]
}

internal class ChickenUsecaseImpl: ChickenUsecase {
    private var repo: ChickenRepository = ChickenRepositoryImpl()
    func fetchChicken(search: String) async throws -> [Chicken] {
        let param = FetchChickenDTO(searchParams: search)
        let response = try await repo.fetchChicken(param: param)
        
        return response.toDomain()
    }
}
