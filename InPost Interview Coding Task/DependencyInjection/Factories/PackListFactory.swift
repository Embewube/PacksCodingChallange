//
//  PackListFactory.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

import UIKit

protocol PackListFactoryProtocol {
    func makePackListController() -> UIViewController
}

final class PackListFactory: PackListFactoryProtocol {
    private let dependencyContainer: PackListDependencyProviding

    init(dependencyContainer: PackListDependencyProviding) {
        self.dependencyContainer = dependencyContainer
    }

    func makePackListController() -> UIViewController {
        let viewModel = makePackListViewModel()

        return PackListController(viewModel: viewModel)
    }
}

private extension PackListFactory {
    func makePackListViewModel() -> PackListViewModel {
        return PackListViewModel(
            getPacksUseCase: dependencyContainer.provideGetPacksUseCase()
        )
    }
}
