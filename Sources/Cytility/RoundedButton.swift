//
//  RoundedButton.swift
//  PlaylistMaker
//
//  Created by Can Yoldas on 19/08/2023.
//

import SwiftUI
import Cytility

public struct RoundedButton : View {
    public enum ButtonStyle {
        case regular
        case fullWidth
    }

    var action: () -> Void
    let label: Text
    var icon: Image?
    var iconColor: Color?
    let buttonStyle: ButtonStyle
    let labelStyle: TextStyle.FontStyle
    let buttonBackground: Color
    let isLoading: Bool
    @Environment(\.isEnabled) var isEnabled: Bool
    
    public init(
        label: String,
        backgroundColor: Color,
        buttonStyle: ButtonStyle = .regular,
        icon: Image? = nil,
        iconColor: Color? = nil,
        labelStyle: TextStyle.FontStyle,
        isLoading: Bool = false,
        action: @escaping () -> Void) {
            self.init(
                label: Text(label),
                backgroundColor: backgroundColor,
                buttonStyle: buttonStyle,
                labelStyle: labelStyle,
                icon: icon,
                iconColor: iconColor,
                isLoading: isLoading,
                action: action)
        }

    public init(
        label: Text,
        backgroundColor: Color,
        buttonStyle: ButtonStyle = .regular,
        labelStyle: TextStyle.FontStyle,
        icon: Image? = nil,
        iconColor: Color? = nil,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.action = action
        self.buttonStyle = buttonStyle
        self.icon = icon
        self.iconColor = iconColor
        self.labelStyle = labelStyle
        self.isLoading = isLoading
        self.buttonBackground = backgroundColor
    }
    
    public var body: some View {
        Button(action: {
            action()
        }, label: {
            ZStack {
                HStack {
                    icon?
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(iconColor ?? .accentColor)
                    AppText(label,
                            style: labelStyle,
                            color: .white)
                }
                .opacity(isLoading ? 0: 1)
                if isLoading {
                    ProgressView()
                }
            }
        })
        .frame(maxWidth: buttonStyle == .fullWidth ? .infinity: nil)
        .disabled(!isEnabled)
        .foregroundStyle(Color.white)
        .padding(.vertical, buttonStyle == .fullWidth ? 14: 10)
        .padding(.horizontal, 12)
        .background(buttonBackground)
        .overlay {
            if !isEnabled {
                Color.gray.opacity(0.4)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .clipped()
    }
}


