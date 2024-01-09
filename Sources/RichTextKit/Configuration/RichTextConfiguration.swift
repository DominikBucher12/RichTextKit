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
    var defaultFont: FontRepresentable { get }
    var linkConfiguration: LinkConfiguration { get }
}

public enum RichTextConfigurations {
    public static let `default`: RichTextConfiguration = RichTextConfigurationImpl(
        foregroundColor: .primary,
        backgroundColor: .clear,
        defaultFont: FontRepresentable.standardRichTextFont,
        linkConfiguration: .none
    )
}

private struct RichTextConfigurationImpl: RichTextConfiguration {
    public var foregroundColor: Color
    public var backgroundColor: Color
    public var defaultFont: FontRepresentable
    public var linkConfiguration: LinkConfiguration
    
    fileprivate init(
        foregroundColor: Color, 
        backgroundColor: Color, 
        defaultFont: FontRepresentable, 
        linkConfiguration: LinkConfiguration
    ) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.defaultFont = defaultFont
        self.linkConfiguration = linkConfiguration
    }
}
