//
//  PackListTableViewCell.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

import UIKit

final class PackListTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "PackListTableViewCell"

    let view = PackView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        view.isUserInteractionEnabled = false
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: PackListItem) {
        view.setup(pack: viewModel)
    }

    private func setupLayout() {
        contentView.addSubview(view)
        backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
