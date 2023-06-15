//
//  UIFont.swift
//  Moovies
//
//  Created by Thant Sin Htun on 09/06/2023.
//

import Foundation
import SwiftUI

extension Font {
    static let RobotoBold       =       "Roboto-Bold"
    static let RobotoMedium     =       "Roboto-Medium"
    static let RobotoRegular    =       "Roboto-Regular"
    static let RobotoLight      =       "Roboto-Light"

}
struct FontModifier : ViewModifier {
    
    let enFont:String
    let enSize:CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom(enFont, size: enSize))
    }
}

extension View {
    func displayMedium(enSize:CGFloat = 24,mmSize:CGFloat = 24) -> some View {
        self.modifier(FontModifier(
            enFont: Font.RobotoMedium,
            enSize: enSize
        ))
    }
    func displayLarge(enSize:CGFloat = 28,mmSize:CGFloat = 28) -> some View {
        self.modifier(FontModifier(
            enFont: Font.RobotoBold,
            enSize: enSize
        ))
    }
    func displaySmall(enSize:CGFloat = 22,mmSize:CGFloat = 22) -> some View {
        self.modifier(FontModifier(
            enFont: Font.RobotoRegular,
            enSize: enSize
        ))
    }
    func bodyMedium(enSize:CGFloat = 16,mmSize:CGFloat = 16) -> some View {
        self.modifier(FontModifier(
            enFont: Font.RobotoRegular,
            enSize: enSize
        ))
    }
    func bodyLarge(enSize:CGFloat = 18,mmSize:CGFloat = 18) -> some View {
        self.modifier(FontModifier(
            enFont: Font.RobotoBold,
            enSize: enSize
        ))
    }
    func bodySmall(enSize:CGFloat = 14,mmSize:CGFloat = 14) -> some View {
        self.modifier(FontModifier(
            enFont: Font.RobotoLight,
            enSize: enSize
        ))
    }
    func titleMedium(enSize:CGFloat = 10,mmSize:CGFloat = 10) -> some View {
        self.modifier(FontModifier(
            enFont: Font.RobotoRegular,
            enSize: enSize
        ))
    }
    func titleLarge(enSize:CGFloat = 12,mmSize:CGFloat = 12) -> some View {
        self.modifier(FontModifier(
            enFont: Font.RobotoRegular,
            enSize: enSize
        ))
    }
    func titleSmall(enSize:CGFloat = 8,mmSize:CGFloat = 8) -> some View {
        self.modifier(FontModifier(
            enFont: Font.RobotoLight,
            enSize: enSize
        ))
    }
}
