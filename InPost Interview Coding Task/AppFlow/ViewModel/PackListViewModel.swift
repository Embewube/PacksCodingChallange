//
//  PackListViewModel.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 02/12/2024.
//

import Combine

protocol PackListViewModelProtocol: ObservableObject {
    var packs: AnyPublisher<[Pack], Never> { get } // wb_TODO: change to item view model
    func loadPacks()
}

final class PackListViewModel: PackListViewModelProtocol {
    @Published private var packsPublisher: [Pack] = []
    private let packNetworking = PackNetworking()

    func loadPacks() {
        packNetworking.getPacks { result in
            if case .success(let packs) = result {
                self.packsPublisher = packs
            }
        }
    }

    var packs: AnyPublisher<[Pack], Never> {
        return $packsPublisher.eraseToAnyPublisher()
    }
}
