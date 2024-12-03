//
//  PackNetworking.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 04/11/2022.
//

import Foundation

protocol PackNetworkingProtocol {
    func getPacks() async throws -> [Pack]
}

// wb_TODO: Move networking to seperate horizontal module / or seperate library
// wb_TODO: abstract networking
class PackNetworking: PackNetworkingProtocol {

    // wb_TODO: inject jsonDecoder
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func getPacks() async throws -> [Pack] {
        let url = Bundle.main.url(forResource: "packs", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let result = try jsonDecoder.decode([Pack].self, from: data)

        try await Task.sleep(for: .seconds(1))

        return result
    }
    
}
