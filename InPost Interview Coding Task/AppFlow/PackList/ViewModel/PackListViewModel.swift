//
//  PackListViewModel.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 02/12/2024.
//

import Combine

protocol PackListViewModelProtocol: ObservableObject {
    var packs: AnyPublisher<[PackListSection], Never> { get }
    func loadPacks()
}

final class PackListViewModel: PackListViewModelProtocol {
    @Published private var packsPublisher: [PackListSection] = []
    private let getPacksUseCase: GetPacksUseCaseProtocol

    init(getPacksUseCase: GetPacksUseCaseProtocol) {
        self.getPacksUseCase = getPacksUseCase
    }

    func loadPacks() {
        Task { [weak self] in
            do {
                self?.packsPublisher = try await self?.getPacksUseCase.get() ?? []
            } catch {
                // wb_TODO: handle error
                self?.packsPublisher = []
            }
        }
    }

    var packs: AnyPublisher<[PackListSection], Never> {
        return $packsPublisher.eraseToAnyPublisher()
    }
}
