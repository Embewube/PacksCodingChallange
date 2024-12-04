//
//  PackListTableViewSectionHeader.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 03/12/2024.
//

import UIKit

final class PackListTableViewSectionHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "PackListTableViewSectionHeader"

    private let font: AppFont = AppFont(
        size: 13,
        weight: 0.6,
        kerning: 0.4,
        lineHeight: 16
    )

    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = font.uiFont
        label.textColor = Colors.GroupingHeader.text
        return label
    }()

    private lazy var leadingDivider: UIView = {
        return makeDivider()
    }()
    private lazy var trailingDivider: UIView = {
        return makeDivider()
    }()

    var title: String? {
        didSet {
            titleLabel.attributedText = NSAttributedString(title, font: font)
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PackListTableViewSectionHeader {
    private func setupView() {
        backgroundColor = .clear
        
        addSubview(stackView)
        stackView.addArrangedSubview(leadingDivider)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(trailingDivider)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutTokens.Padding.l),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutTokens.Padding.l),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutTokens.Padding.m),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutTokens.Padding.m),

            leadingDivider.heightAnchor.constraint(equalToConstant: 1),
            trailingDivider.heightAnchor.constraint(equalToConstant: 1),
            leadingDivider.widthAnchor.constraint(equalTo: trailingDivider.widthAnchor),
        ])
    }

    private func makeDivider() -> UIView {
        let divider = UIView()
        divider.backgroundColor = Colors.GroupingHeader.divider
        return divider
    }
}
