//
//  URLFactory.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

import Foundation

protocol URLFactoryProtocol {
    func makePacksURL() -> URL
}

struct URLFactory: URLFactoryProtocol {
    private let baseURL = "https://someurl.com"

    func makePacksURL() -> URL {
        return makeURL(apiEndpoint: .packs)
    }
}

private extension URLFactory {
    func makeURL(apiEndpoint: APIEndpoint) -> URL {
        return Bundle.main.url(forResource: "packs", withExtension: "json")!
    }
}
