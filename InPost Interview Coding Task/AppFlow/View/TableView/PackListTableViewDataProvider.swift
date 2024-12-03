//
//  PackListTableViewDataProvider.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

import UIKit

protocol PackListTableViewDataProviderProtocol: NSObject, UITableViewDataSource {
    var sections: [PackListSection] { get set }

    func setup(tableView: UITableView)
}

class PackListTableViewDataProvider: NSObject {
    private weak var tableView: UITableView?

    var sections: [PackListSection] = [] {
        didSet {
            guard sections != oldValue else {
                return
            }

            tableView?.reloadData()
        }
    }
}

// MARK: - PackListTableViewDataProviderProtocol

extension PackListTableViewDataProvider: PackListTableViewDataProviderProtocol {
    func setup(tableView: UITableView) {
        self.tableView = tableView
        tableView.separatorStyle = .none

        tableView.register(
            PackListTableViewCell.self,
            forCellReuseIdentifier: PackListTableViewCell.reuseIdentifier
        )
        tableView.register(
            PackListTableViewSectionHeader.self,
            forHeaderFooterViewReuseIdentifier: PackListTableViewSectionHeader.reuseIdentifier
        )
    }

    // MARK: - Sections

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section < sections.count else {
            return nil
        }

        return sections[section].title
    }

    // MARK: - Rows

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < sections.count else {
            return 0
        }

        return sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PackListTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! PackListTableViewCell

        cell.selectionStyle = .none

        guard
            indexPath.section < sections.count,
            indexPath.row < sections[indexPath.section].items.count
        else {
            return cell
        }

        let item = sections[indexPath.section].items[indexPath.row]
        cell.configure(with: item)

        return cell
    }
}
