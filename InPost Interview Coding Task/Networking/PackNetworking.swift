//
//  PackNetworking.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 04/11/2022.
//

import Foundation

protocol PacksNetworkingProtocol {
    func getPacks() async throws -> [Pack]
}

struct PacksNetworking {
    private let networkService: NetworkServiceProtocol
    private let urlFactory: URLFactoryProtocol

    init(
        networkService: NetworkServiceProtocol,
        urlFactory: URLFactoryProtocol
    ) {
        self.networkService = networkService
        self.urlFactory = urlFactory
    }
}

extension PacksNetworking: PacksNetworkingProtocol {
    func getPacks() async throws -> [Pack] {
        let url = urlFactory.makePacksURL()
        return try await networkService.fetch(url: url)
    }
}
