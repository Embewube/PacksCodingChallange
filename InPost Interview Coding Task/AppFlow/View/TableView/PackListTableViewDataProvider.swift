//
//  PackListTableViewDataProvider.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

import UIKit

protocol PackListTableViewDataProviderProtocol: NSObject, UITableViewDataSource, UITableViewDelegate {
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
        tableView.separatorStyle = .none

        tableView.register(
            PackListTableViewCell.self,
            forCellReuseIdentifier: PackListTableViewCell.reuseIdentifier
        )
        tableView.register(
            PackListTableViewSectionHeader.self,
            forHeaderFooterViewReuseIdentifier: PackListTableViewSectionHeader.reuseIdentifier
        )
        self.tableView = tableView
    }
}

extension PackListTableViewDataProvider: UITableViewDataSource, UITableViewDelegate {

    // MARK: - Sections

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        guard section < sections.count else {
            return nil
        }

        let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: PackListTableViewSectionHeader.reuseIdentifier
        ) as! PackListTableViewSectionHeader

        headerView.title = sections[section].title

        return headerView
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 48
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
