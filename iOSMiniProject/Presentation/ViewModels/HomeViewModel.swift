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
    @Published var filteredChickens: [Chicken] = []
    
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
            self.filteredChickens = chickens
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func filterChickens(by searchText: String) {
        if searchText.isEmpty {
            filteredChickens = chickens
        } else {
            filteredChickens = chickens.filter { chicken in
                chicken.menuName.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
