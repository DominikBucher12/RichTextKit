//
//  RichTextLinkButton.swift
//
//
//  Created by Dominik Bucher on 01.12.2023.
//

import SwiftUI

/// This button can be used to toggle a ``Link`` value.
///
/// This view renders a plain `Button`, which means you can use
/// and configure it in all ways supported by SwiftUI. The only
/// exception is the content color, which is set by a style you
/// can provide in the initializer.
///
/// If you want a more prominent button, you may consider using
/// a ``RichTextStyleToggle`` instead, but it requires a higher
/// deployment target.
public struct RichTextLinkButton: View {
    @ObservedObject var context: RichTextContext
    @State private var urlString = ""
    @Binding private var isAlertPresented: Bool
    
    private let fillVertically: Bool
    private let value: Binding<URL?>
    
    public init(
        context: RichTextContext,
        isAlertPresented: Binding<Bool>,
        value: Binding<URL?>,
        fillVertically: Bool = false
    ) {
        self.context = context
        self._isAlertPresented = isAlertPresented
        self.value = value
        self.fillVertically = fillVertically
    }
    
    public var body: some View {
        Button(action: toggle) {
            Image.richTextKindLink
                .frame(maxHeight: fillVertically ? .infinity : nil)
                .foregroundColor(tintColor)
                .contentShape(Rectangle())
        }
    }
}

extension View {
    func newAlert(
        _ title: String,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> some View
    ) -> some View {
        alert(
            "URL",
            isPresented: isPresented,
            actions: actions
        )
    }
}

extension RichTextLinkButton {
    private var isOn: Bool {
        value.wrappedValue != nil
    }
    
    private var tintColor: Color {
        isOn ? .blue : .black
    }
    
    private func toggle() {
        if value.wrappedValue != nil {
            context.setLink(nil)
        } else {
            isAlertPresented = true
        }
    }
}

struct RichTextLinkButton_Previews: PreviewProvider {
    struct Preview: View {
        var body: some View {
            HStack(spacing: 8) {
                RichTextLinkButton(
                    context: RichTextContext(),
                    isAlertPresented: .constant(false), value: .constant(nil)
                )
            }.padding(8)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}

