//
//  UIFonts.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 24/12/24.
//

import SwiftUI

enum SizeFamily: String {
    case light = "Light"
    case regular = "Regular"
    case bold = "Bold"
    case black = "Black"
    case semibold = "SemiBold"
}

enum AppFontFamily: String {
    case nunito = "Nunito"
}

extension Font {
    static func customFont(family: AppFontFamily, sizeFamily: SizeFamily, size: CGFloat) -> Font {
        return Font.custom("\(family.rawValue)-\(sizeFamily.rawValue)", size: size)
    }
}
