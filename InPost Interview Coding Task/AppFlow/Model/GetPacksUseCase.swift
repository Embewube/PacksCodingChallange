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
    private let packNetworking: PackNetworkingProtocol
    private let mapper: PackMapping

    init(
        packNetworking: PackNetworkingProtocol,
        mapper: PackMapping
    ) {
        self.packNetworking = packNetworking
        self.mapper = mapper
    }

    func get() async throws -> [PackListItemViewModel] {
        return try await packNetworking.getPacks()
            .map(mapper.map)
    }
}
