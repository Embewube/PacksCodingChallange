//
//  PackListTableViewSectionHeader.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

import UIKit

final class PackListTableViewSectionHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "PackListTableViewSectionHeader"

    var title: String? {
        didSet {
            textLabel?.text = title
        }
    }

}
