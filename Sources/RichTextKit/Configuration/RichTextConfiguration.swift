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
    case customColor(ColorRepresentable)
}

public protocol RichTextConfiguration {
    var foregroundColor: ColorRepresentable { get }
    var backgroundColor: ColorRepresentable { get }
    var defaultFont: FontRepresentable { get }
    var linkConfiguration: LinkConfiguration { get }
}

public enum RichTextConfigurations {
    public static let `default`: RichTextConfiguration = RichTextConfigurationImpl(
        foregroundColor: ColorRepresentable.label,
        backgroundColor: ColorRepresentable.clear,
        defaultFont: FontRepresentable.standardRichTextFont,
        linkConfiguration: .none
    )
}

private struct RichTextConfigurationImpl: RichTextConfiguration {
    public var foregroundColor: ColorRepresentable
    public var backgroundColor: ColorRepresentable
    public var defaultFont: FontRepresentable
    public var linkConfiguration: LinkConfiguration
    
    fileprivate init(
        foregroundColor: ColorRepresentable, 
        backgroundColor: ColorRepresentable, 
        defaultFont: FontRepresentable, 
        linkConfiguration: LinkConfiguration
    ) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.defaultFont = defaultFont
        self.linkConfiguration = linkConfiguration
    }
}
