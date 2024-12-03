//
//  PackListTableViewDataProvider.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

import UIKit

protocol PackListTableViewDataProviderProtocol: NSObject, UITableViewDataSource {
    var items: [PackListItemViewModel] { get set }

    func setup(tableView: UITableView)
}

class PackListTableViewDataProvider: NSObject {
    private weak var tableView: UITableView?

    var items: [PackListItemViewModel] = [] {
        didSet {
            guard items != oldValue else {
                return
            }

            tableView?.reloadData()
        }
    }
}

extension PackListTableViewDataProvider: PackListTableViewDataProviderProtocol {
    func setup(tableView: UITableView) {
        self.tableView = tableView
        tableView.separatorStyle = .none
        tableView.register(
            PackListTableViewCell.self,
            forCellReuseIdentifier: PackListTableViewCell.reuseIdentifier
        )
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PackListTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! PackListTableViewCell

        let item = items[indexPath.row]
        cell.configure(with: item)
        cell.selectionStyle = .none

        return cell
    }
}
