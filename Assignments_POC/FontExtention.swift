//
//  FontExtention.swift
//  Assignments_POC
//
//  Created by Arjunan on 07/02/24.
//

import SwiftUI

enum FontWeight: String {
    case light = "Light"
    case regular = "Regular"
    case medium = "Medium"
    case semibold = "Semibold"
    case bold = "Bold"
}

extension Font {
    static func fontSFProText(ofSize: CGFloat, weight: FontWeight = .regular) -> Font {
        return Font.custom("SFProText-\(weight.rawValue)", size: ofSize)
    }
}
