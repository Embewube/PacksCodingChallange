//
//  GetPacksUseCase.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 02/12/2024.
//

protocol GetPacksUseCaseProtocol {
    func get() async throws -> [PackListSection]
}

struct GetPacksUseCase: GetPacksUseCaseProtocol {
    private let packsNetworking: PacksNetworkingProtocol
    private let packsOrganizer: PacksOrganizing
    private let packsSorter: PacksSorting
    private let mapper: PackMapping

    init(
        packsNetworking: PacksNetworkingProtocol,
        packsOrganizer: PacksOrganizing,
        packsSorter: PacksSorting,
        mapper: PackMapping
    ) {
        self.packsNetworking = packsNetworking
        self.packsOrganizer = packsOrganizer
        self.packsSorter = packsSorter
        self.mapper = mapper
    }

    func get() async throws -> [PackListSection] {
        let packs = try await packsNetworking.getPacks()
        let groupedPacks = packsOrganizer.group(packs: packs)
        let groupsWithSortedPacks = packsSorter.sortPacks(in: groupedPacks)

        return mapper.map(groupsWithSortedPacks)
    }
}
