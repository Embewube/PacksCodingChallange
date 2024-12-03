//
//  ViewController.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import Combine
import UIKit

class PackListController: UIViewController {
    private let viewModel: any PackListViewModelProtocol = PackListViewModel() // wb_TODO: use DI
    private let packListView: PackListViewProtocol = PackListView()
    private let tableViewDataProvider: PackListTableViewDataProviderProtocol = PackListTableViewDataProvider() // wb_TODO: use DI
    private var cancellables: Set<AnyCancellable> = []

    init() { // wb_TODO: inject viewModel and view and data provider
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

        setupBindings()
        viewModel.loadPacks()
    }

    private func setupBindings() {
        viewModel.packs
            .receive(on: DispatchQueue.main)
            .sink { [weak self] packs in
                self?.tableViewDataProvider.items = packs
            }
            .store(in: &cancellables)
    }
}
