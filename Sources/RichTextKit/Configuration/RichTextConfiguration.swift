//
//  RichTextConfiguration.swift
//
//
//  Created by Dominik Bucher on 09.01.2024.
//

import Foundation
import SwiftUI

public enum LinkConfiguration {
    case none
    case customLinkAttributes(RichTextAttributes)
    case customColor(Color)
}

public protocol RichTextConfiguration {
    var foregroundColor: Color { get }
    var backgroundColor: Color { get }
    var defaultFont: Font { get }
    var linkConfiguration: LinkConfiguration { get }
}

extension RichTextConfiguration {
    public var `default`: RichTextConfiguration {
        RichTextConfigurationImpl(
            foregroundColor: .primary,
            backgroundColor: .clear,
            defaultFont: .system(size: 16),
            linkConfiguration: .none
        )
    }
}

private struct RichTextConfigurationImpl: RichTextConfiguration {
    var foregroundColor: Color
    var backgroundColor: Color
    var defaultFont: Font
    var linkConfiguration: LinkConfiguration
    
    fileprivate init(foregroundColor: Color, backgroundColor: Color, defaultFont: Font, linkConfiguration: LinkConfiguration) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.defaultFont = defaultFont
        self.linkConfiguration = linkConfiguration
    }
}
