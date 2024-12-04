//
//  ViewController.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import Combine
import UIKit

// wb_TODO: move PackList to a seperate vertical module
class PackListController: UIViewController {
    // Dependencies
    private let viewModel: any PackListViewModelProtocol
    private let packListView: PackListViewProtocol
    private let tableViewDataProvider: PackListTableViewDataProviderProtocol

    // Other properties
    private var cancellables: Set<AnyCancellable> = []

    init(
        viewModel: any PackListViewModelProtocol,
        view: PackListViewProtocol,
        tableViewDataProvider: PackListTableViewDataProviderProtocol
    ) {
        self.viewModel = viewModel
        self.packListView = view
        self.tableViewDataProvider = tableViewDataProvider

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = packListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Lista przesyłek"

        tableViewDataProvider.setup(tableView: packListView.tableView)
        packListView.tableView.dataSource = tableViewDataProvider
        packListView.tableView.delegate = tableViewDataProvider

        setupBindings()
        viewModel.loadPacks()
    }
}

// MARK: - Private

private extension PackListController {
    func setupBindings() {
        // wb_TODO: add loader or skeleton
        viewModel.packs
            .receive(on: DispatchQueue.main)
            .sink { [weak self] packs in
                self?.tableViewDataProvider.sections = packs
            }
            .store(in: &cancellables)
    }
}
