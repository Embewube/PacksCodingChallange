//
//  AppFont.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 04/12/2024.
//

import UIKit

public struct AppFont {
    private static let defaultFontName = "Montserrat"

    public let name: String
    public let size: CGFloat
    public let weight: CGFloat
    public let kerning: CGFloat
    public let lineHeight: CGFloat

    init(
        name: String = defaultFontName,
        size: CGFloat,
        weight: CGFloat,
        kerning: CGFloat,
        lineHeight: CGFloat
    ) {
        self.name = name
        self.size = size
        self.weight = weight
        self.kerning = kerning
        self.lineHeight = lineHeight
    }

    var uiFont: UIFont {
        let descriptor = UIFontDescriptor(fontAttributes: [
            UIFontDescriptor.AttributeName.family: name,
            UIFontDescriptor.AttributeName.traits: [
                UIFontDescriptor.TraitKey.weight: weight,
            ]
        ])

        return UIFont(descriptor: descriptor, size: size)
    }
}
