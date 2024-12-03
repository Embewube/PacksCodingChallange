//
//  PackListDependencyProvider.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

protocol PackListDependencyProviding {
    func provideGetPacksUseCase() -> GetPacksUseCaseProtocol // wb_TODO: consider moving it to common dependencies
}

final class PackListDependencyProvider: PackListDependencyProviding {
    private let dependencyProvider: DependencyProvidersContaining

    init(dependencyProvider: DependencyProvidersContaining = DependencyProvidersContainer.shared) {
        self.dependencyProvider = dependencyProvider
    }

    func provideGetPacksUseCase() -> any GetPacksUseCaseProtocol {
        return GetPacksUseCase(
            packsNetworking: dependencyProvider.providePacksNetworking(),
            packsOrganizer: PacksOrganizer(), 
            mapper: PackMapper()
        )
    }
}
