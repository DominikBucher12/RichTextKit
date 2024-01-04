//
//  RichTextFormatSheet.swift
//  RichTextKit
//
//  Created by Daniel Saidi on 2022-12-13.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

#if iOS
import SwiftUI

/**
 This sheet view provides different text format options, and
 is meant to be used on iOS, where space is limited.

 The font picker will take up as much height as it can after
 the other rows have allocated their height.
 */
public struct RichTextFormatSheet: View {

    /**
     Create a rich text format sheet.

     - Parameters:
       - context: The context to apply changes to.
       - colorPickers: The color pickers to use, by default `.foreground` and `.background`.
     */
    public init(
        context: RichTextContext,
        colorPickers: [RichTextColor] = [.foreground, .background]
    ) {
        self._context = ObservedObject(wrappedValue: context)
        self.colorPickers = colorPickers
    }

    @ObservedObject
    private var context: RichTextContext

    @Environment(\.presentationMode)
    private var presentationMode

    /// The sheet padding.
    public var padding = 10.0

    /// The sheet top offset.
    public var topOffset = -35.0

    /// The color pickers to use.
    public var colorPickers: [RichTextColor]

    public var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                RichTextFontListPicker(selection: $context.fontName)
                    .offset(y: topOffset)
                    .padding(.bottom, topOffset)
                Divider()
                VStack(spacing: padding) {
                    VStack {
                        fontRow
                        paragraphRow
                        Divider()
                    }.padding(.horizontal, padding)
                    VStack(spacing: padding) {
                        ForEach(colorPickers) {
                            RichTextColorPicker(
                                type: $0,
                                value: context.binding(for: $0),
                                quickColors: .quickPickerColors
                            )
                        }
                    }.padding(.leading, padding)
                }
                .padding(.vertical, padding)
                .environment(\.sizeCategory, .medium)
                .accentColor(.primary)
                .background(background)
            }
            .withAutomaticToolbarRole()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EmptyView()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(RTKL10n.done.text) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
    }
}

private extension RichTextFormatSheet {

    var fontRow: some View {
        HStack {
            styleButtons
            Spacer()
            RichTextFontSizePickerStack(context: context)
                .buttonStyle(.bordered)
        }
    }

    var paragraphRow: some View {
        HStack {
            RichTextAlignmentPicker(selection: $context.textAlignment)
                .pickerStyle(.segmented)
            Spacer()
            indentButtons
        }
    }
}

private extension RichTextFormatSheet {

    var background: some View {
        Color.clear
            .overlay(Color.primary.opacity(0.1))
            .shadow(color: .black.opacity(0.1), radius: 5)
            .edgesIgnoringSafeArea(.all)
    }

    @ViewBuilder
    var indentButtons: some View {
        RichTextActionButtonGroup(
            context: context,
            actions: [.decreaseIndent, .increaseIndent],
            greedy: false
        )
    }

    @ViewBuilder
    var styleButtons: some View {
        RichTextStyleToggleGroup(
            context: context
        )
    }
}

private extension View {

    @ViewBuilder
    func withAutomaticToolbarRole() -> some View {
        if #available(iOS 16.0, *) {
            self.toolbarRole(.automatic)
        } else {
            self
        }
    }
}

struct RichTextFormatSheet_Previews: PreviewProvider {

    struct Preview: View {

        @StateObject
        private var context = RichTextContext()

        var body: some View {
            RichTextFormatSheet(context: context)
        }
    }

    static var previews: some View {
        Preview()
    }
}
#endif
