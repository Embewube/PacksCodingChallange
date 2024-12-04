//
//  NSAttributedString+AppFont.swift
//  InPost Interview Coding Task
//
//  Created by Wiktor Biruk on 04/12/2024.
//

import UIKit

extension NSAttributedString {
    convenience init?(_ text: String?, font: AppFont) {
        guard let text else { return nil }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = font.lineHeight
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
