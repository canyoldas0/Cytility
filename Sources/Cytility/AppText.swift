//
//  AppText.swift
//
//  Created by Can Yoldas on 29/07/2023.
//

import SwiftUI

public struct TextStyle {
    public enum FontWeight {
        case medium, regular, semiBold, bold
    }
    
    public enum FontStyle {
        case body
        case smallBody
        case largeTitle
        case title
        case button
        case plainButton
        case caption
        case custom(FontWeight, CGFloat)
    }
    
    let textColor: Color
    let fontStyle: FontStyle
    
    public var font: Font {
        switch fontStyle {
        case .largeTitle:
            return .inter(.semiBold, 28)
        case .body:
            return .inter(.regular, 17)
        case .smallBody:
            return .inter(.regular, 14)
        case .title:
            return .inter(.semiBold, 22)
        case .button:
            return .inter(.semiBold, 15)
        case .plainButton:
            return .inter(.medium, 15)
        case .caption:
            return .inter(.regular, 13)
        case .custom(let weight, let size):
            switch weight {
            case .medium:
                return .inter(.medium, size)
            case .regular:
                return .inter(.regular, size)
            case .semiBold:
                return .inter(.semiBold, size)
            case .bold:
                return .inter(.bold, size)
            }
        }
    }
}

/// Requires to add Inter font files.
// TODO: Inject font to TextStyle.
public struct AppText: View {
    let text: Text
    let textStyle: TextStyle
    
    public init(
        _ text: Text,
        style: TextStyle.FontStyle,
        color: Color
    ) {
        self.text = text
        self.textStyle = .init(textColor: color, fontStyle: style)
    }
    
    public init(
        _ text: String,
        style: TextStyle.FontStyle,
        color: Color) {
            self.init(
                Text(text),
                style: style,
                color: color
            )
        }
    
    public var body: some View {
        text
            .foregroundColor(textStyle.textColor)
            .font(textStyle.font)
    }
}

struct AppText_Previews: PreviewProvider {
    static var previews: some View {
        AppText("Hello", style: .largeTitle, color: Color.gray)
    }
}

extension Font {
    enum Inter: String {
        case light
        case medium
        case regular
        case semiBold
        case bold
        
        var name: String {
            return "Inter-\(self.rawValue.capitalized)"
        }
    }
    
    static func inter(_ type: Inter, _ size: CGFloat = 16) -> Font {
        // first check whether font is available, else fallback to system font
        return .custom(type.name, size: size)
    }
}


