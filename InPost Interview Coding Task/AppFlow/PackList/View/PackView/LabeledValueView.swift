//
//  LabeledValueView.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 04/12/2024.
//

import UIKit

class LabeledValueView: UIView {
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    private let titleFont: AppFont
    private let valueFont: AppFont
    private var textAlignmet: NSTextAlignment

    private let titleColor: UIColor
    private let valueColor: UIColor

    var title: String? {
        didSet {
            titleLabel.attributedText = NSAttributedString(
                title,
                font: titleFont,
                alignment: textAlignmet
            )
        }
    }

    var value: String? {
        didSet {
            valueLabel.attributedText = NSAttributedString(
                value,
                font: valueFont,
                alignment: textAlignmet
            )
        }
    }

    init(
        frame: CGRect = .zero,
        titleFont: AppFont,
        valueFont: AppFont,
        titleColor: UIColor,
        valueColor: UIColor,
        textAlignmet: NSTextAlignment = .left
    ) {
        self.titleFont = titleFont
        self.valueFont = valueFont
        self.titleColor = titleColor
        self.valueColor = valueColor
        self.textAlignmet = textAlignmet

        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LabeledValueView {
    private func setupView() {
        setupViewHierarchy()

        setupStackView()
        setupTitleLabel()
        setupValueLabel()
    }

    private func setupViewHierarchy() {
        addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupTitleLabel() {
        titleLabel.font = titleFont.uiFont
        titleLabel.textColor = titleColor
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
    }

    private func setupValueLabel() {
        valueLabel.font = valueFont.uiFont
        valueLabel.textColor = valueColor
        valueLabel.textAlignment = .left
        valueLabel.numberOfLines = 2
    }
}
