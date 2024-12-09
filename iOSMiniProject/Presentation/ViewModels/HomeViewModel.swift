//
//  HomeViewModel.swift
//  iOSMiniProject
//
//  Created by Jonathan Aaron Wibawa on 05/12/24.
//

import Foundation
import UIKit

internal class HomeViewModel {
    @Published var chickens: [Chicken] = []
    private var usecase: ChickenUsecase = ChickenUsecaseImpl()
    
    init() {
        Task {
            await fetchChickens()
        }
    }
    
    private func fetchChickens() async {
        do {
            let chickens = try await self.usecase.fetchChicken(search: "chicken")
            self.chickens = chickens
        } catch {
            print(error.localizedDescription)
        }
    }
}
