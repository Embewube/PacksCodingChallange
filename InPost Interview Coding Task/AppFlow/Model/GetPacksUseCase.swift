//
//  GetPacksUseCase.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 02/12/2024.
//

protocol GetPacksUseCaseProtocol {
    func get() async throws -> [PackListItemViewModel]
}

struct GetPacksUseCase: GetPacksUseCaseProtocol {
    private let packNetworking = PackNetworking() // wb_TODO: use dependency injection
    private let mapper: PackMapping = PackMapper() // wb_TODO: use dependency injection

    func get() async throws -> [PackListItemViewModel] {
        return try await packNetworking.getPacks()
            .map(mapper.map)
    }
}
