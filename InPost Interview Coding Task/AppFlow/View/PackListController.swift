//
//  ViewController.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import Combine
import UIKit

class PackListController: UIViewController {
    private let viewModel: any PackListViewModelProtocol = PackListViewModel() // wb_TODO: use protocol and DI
    private var cancellables: Set<AnyCancellable> = []

    @IBOutlet private var stackView: UIStackView! // wb_TODO: replace with table view

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Lista przesyłek"

        setupBindings()
        viewModel.loadPacks()
    }

    private func setupBindings() {
        viewModel.packs
            .print("AAA")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] packs in
                self?.removePacks()

                packs.forEach { pack in
                    self?.addPackView(pack)
                }
            }
            .store(in: &cancellables)
    }

    private func removePacks() {
        stackView.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    private func addPackView(_ pack: PackListItemViewModel) {
        let packView = PackView()
        packView.setup(pack: pack)
        stackView.addArrangedSubview(packView)
    }

}
