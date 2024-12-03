//
//  PackListViewModel.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 02/12/2024.
//

import Combine

protocol PackListViewModelProtocol: ObservableObject {
    var packs: AnyPublisher<[PackListItemViewModel], Never> { get } // wb_TODO: change to item view model
    func loadPacks()
}

final class PackListViewModel: PackListViewModelProtocol {
    @Published private var packsPublisher: [PackListItemViewModel] = []
    private let getPacksUseCase: GetPacksUseCaseProtocol

    init(getPacksUseCase: GetPacksUseCaseProtocol) {
        self.getPacksUseCase = getPacksUseCase
    }

    func loadPacks() {
        Task {
            do {
                packsPublisher = try await getPacksUseCase.get()
            } catch {
                // wb_TODO: handle error
            }
        }
    }

    var packs: AnyPublisher<[PackListItemViewModel], Never> {
        return $packsPublisher.eraseToAnyPublisher()
    }
}
