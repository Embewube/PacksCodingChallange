//
//  NSAttributedString+AppFont.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 04/12/2024.
//

import UIKit

extension NSAttributedString {
    convenience init?(
        _ text: String?,
        font: AppFont,
        alignment: NSTextAlignment? = nil
    ) {
        guard let text else { return nil }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = font.lineHeight
        paragraphStyle.alignment = alignment ?? .left
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .kern: font.kerning,
            ]
        )

        self.init(attributedString: attributedString)
    }
}
