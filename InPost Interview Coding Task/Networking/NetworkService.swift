//
//  NetworkService.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

// wb_TODO: Move networking to seperate horizontal module / or seperate library

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(url: URL) async throws -> T
}

final class NetworkService {
    private let jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder = .init()) {
        self.jsonDecoder = jsonDecoder
    }
}

extension NetworkService: NetworkServiceProtocol {
    func fetch<T: Decodable>(url: URL) async throws -> T {
        // NOTE: network simulation
        let data = try Data(contentsOf: url)
        let result = try jsonDecoder.decode(T.self, from: data)

        try await Task.sleep(for: .seconds(1))

        return result
    }
}

