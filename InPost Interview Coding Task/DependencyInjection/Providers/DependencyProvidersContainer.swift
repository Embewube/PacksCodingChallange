//
//  DependencyProvidersContainer.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

protocol DependencyProvidersContaining {
    var packListDependencyProvider: PackListDependencyProvider { get }

    func providePackNetworking() -> PackNetworking
}

final class DependencyProvidersContainer: DependencyProvidersContaining {
    static let shared = DependencyProvidersContainer()

    var packListDependencyProvider: PackListDependencyProvider {
        return PackListDependencyProvider()
    }

    func providePackNetworking() -> PackNetworking {
        return PackNetworking()
    }
}
