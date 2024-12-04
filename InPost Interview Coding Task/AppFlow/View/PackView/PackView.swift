//
//  PackView.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import UIKit

class PackView: UIView {
    private enum Constants {
        static let labeledValueViewTitleFont = AppFont(
            size: 11,
            weight: 0.3,
            kerning: 0.4,
            lineHeight: 16
        )
        static let labeledValueViewValueFont = AppFont(
            size: 15,
            weight: 0.25,
            kerning: 0.4,
            lineHeight: 24
        )
        static let boldLabeledValueViewValueFont = AppFont(
            size: 15,
            weight: 0.35,
            kerning: 0.4,
            lineHeight: 24
        )
        static let buttonFont = AppFont(
            size: 12,
            weight: 0.35,
            kerning: 0.4,
            lineHeight: 16
        )
    }

    // wb_TODO: handle shadow between sections
    private let contentContainer = UIView()
    private let backgroundView = UIView()
    private let mainVerticalStackView = UIStackView()
    private let packIDStackView = UIStackView()
    private let idLabeledValueView = LabeledValueView(
        titleFont: Constants.labeledValueViewTitleFont,
        valueFont: Constants.labeledValueViewValueFont,
        titleColor: Colors.PackList.itemLabel,
        valueColor: Colors.PackList.itemValue
    )
    private let icon = UIImageView()
    private let statusStackView = UIStackView()
    private let statusLabeledValueView = LabeledValueView(
        titleFont: Constants.labeledValueViewTitleFont,
        valueFont: Constants.boldLabeledValueViewValueFont,
        titleColor: Colors.PackList.itemLabel,
        valueColor: Colors.PackList.itemValue
    )
    private let expirationLabeledValueView = LabeledValueView(
        titleFont: Constants.labeledValueViewTitleFont,
        valueFont: Constants.labeledValueViewValueFont,
        titleColor: Colors.PackList.itemLabel,
        valueColor: Colors.PackList.itemValue,
        textAlignmet: .right
    )
    private let senderStackView = UIStackView()
    private let senderLabeledValueView = LabeledValueView(
        titleFont: Constants.labeledValueViewTitleFont,
        valueFont: Constants.boldLabeledValueViewValueFont,
        titleColor: Colors.PackList.itemLabel,
        valueColor: Colors.PackList.itemValue
    )
    private let moreButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(pack: PackListItem) {
        idLabeledValueView.value = pack.id
        icon.image = UIImage(named: pack.iconName)

        statusLabeledValueView.value = pack.status
        expirationLabeledValueView.isHidden = pack.isExpirationHidden
        expirationLabeledValueView.value = pack.expiration

        senderLabeledValueView.value = pack.sender
    }
}

private extension PackView {

    private func setupView() {
        backgroundColor = .clear
        setupViewHierarchy()

        setupContentContainer()
        setupBackgroundView()
        setupMainVerticalStackView()
        setupPackIDStackView()
        setupIcon()
        setupExpirationLabeledValueView()
        setupSenderStackView()
        setupMoreButton()

        setupTexts()
    }

    private func setupViewHierarchy() {
        addSubview(contentContainer)
        contentContainer.addSubview(backgroundView)
        backgroundView.addSubview(mainVerticalStackView)

        mainVerticalStackView.addArrangedSubview(packIDStackView)
        mainVerticalStackView.addArrangedSubview(statusStackView)
        mainVerticalStackView.addArrangedSubview(senderStackView)

        packIDStackView.addArrangedSubview(idLabeledValueView)
        packIDStackView.addArrangedSubview(UIView()) // flexible spacing
        packIDStackView.addArrangedSubview(icon)

        statusStackView.addArrangedSubview(statusLabeledValueView)
        statusStackView.addArrangedSubview(UIView()) // flexible spacing
        statusStackView.addArrangedSubview(expirationLabeledValueView)

        senderStackView.addArrangedSubview(senderLabeledValueView)
        senderStackView.addArrangedSubview(UIView()) // flexible spacing
        senderStackView.addArrangedSubview(moreButton)
    }

    private func setupContentContainer() {
        contentContainer.backgroundColor = .clear
        contentContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentContainer.topAnchor.constraint(equalTo: topAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setupBackgroundView() {
        backgroundView.backgroundColor = Colors.PackList.itemBackground
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        // TODO: Look out for shadow performance?
        backgroundView.layer.shadowColor = Colors.PackList.itemShadow.cgColor
        backgroundView.layer.shadowRadius = 10
        backgroundView.layer.shadowOffset = .init(width: 0, height: 10)
        backgroundView.layer.shadowOpacity = 1

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            backgroundView.bottomAnchor.constraint(
                equalTo: contentContainer.bottomAnchor,
                constant: -LayoutTokens.Padding.m
            ),
        ])
    }

    private func setupMainVerticalStackView() {
        mainVerticalStackView.axis = .vertical
        mainVerticalStackView.spacing = LayoutTokens.Spacing.m
        mainVerticalStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainVerticalStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: LayoutTokens.Padding.l),
            mainVerticalStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -LayoutTokens.Padding.l),
            mainVerticalStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: LayoutTokens.Padding.m),
            mainVerticalStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -LayoutTokens.Padding.s),
        ])
    }

    private func setupPackIDStackView() {
        packIDStackView.axis = .horizontal
        packIDStackView.alignment = .center
    }

    private func setupIcon() {
        icon.contentMode = .scaleAspectFit
    }

    private func setupStatusStackView() {
        packIDStackView.axis = .horizontal
        packIDStackView.alignment = .top
    }

    private func setupExpirationLabeledValueView() {
        expirationLabeledValueView.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    private func setupSenderStackView() {
        senderStackView.axis = .horizontal
        senderStackView.alignment = .center
    }

    private func setupMoreButton() {
        moreButton.setTitleColor(Colors.PackList.buttonColor, for: .normal)
        moreButton.titleLabel?.font = Constants.buttonFont.uiFont
        let attributedTitle = NSAttributedString("więcej ", font: Constants.buttonFont)
        moreButton.setAttributedTitle(attributedTitle, for: .normal)
        moreButton.setImage(UIImage(resource: ImageResource.arrow), for: .normal)
        moreButton.semanticContentAttribute = .forceRightToLeft
    }

    private func setupTexts() {
        idLabeledValueView.title = "NR PRZESYŁKI" // wb_TODO: use translations
        statusLabeledValueView.title = "STATUS"
        expirationLabeledValueView.title = "CZEKA NA ODBIOR DO"
        senderLabeledValueView.title = "NADAWCA"
    }

}
