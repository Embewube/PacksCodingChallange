//
//  DependencyProvidersContainer.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

import Foundation

protocol DependencyProvidersContaining {
    var packListDependencyProvider: PackListDependencyProvider { get }
    var networkService: NetworkServiceProtocol { get }
    var urlFactory: URLFactoryProtocol { get }

    func providePacksNetworking() -> PacksNetworking
}

final class DependencyProvidersContainer: DependencyProvidersContaining {
    static let shared = DependencyProvidersContainer()

    var networkService: NetworkServiceProtocol {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return NetworkService(jsonDecoder: decoder)
    }

    var urlFactory: any URLFactoryProtocol {
        return URLFactory()
    }

    var packListDependencyProvider: PackListDependencyProvider {
        return PackListDependencyProvider()
    }

    func providePacksNetworking() -> PacksNetworking {
        return PacksNetworking(
            networkService: networkService,
            urlFactory: urlFactory
        )
    }
}
