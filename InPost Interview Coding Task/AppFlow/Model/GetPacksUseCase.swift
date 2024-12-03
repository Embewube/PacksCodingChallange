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
    private let packsNetworking: PacksNetworkingProtocol
    private let mapper: PackMapping

    init(
        packsNetworking: PacksNetworkingProtocol,
        mapper: PackMapping
    ) {
        self.packsNetworking = packsNetworking
        self.mapper = mapper
    }

    func get() async throws -> [PackListItemViewModel] {
        return try await packsNetworking.getPacks()
            .map(mapper.map)
    }
}
