/**
 *  ActionSheetCardItem
 *
 *  Copyright (c) 2021 Mahmud Ahsan. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

import SwiftUI

public struct ActionSheetCardItem: View {
    let id = UUID()
    let systemIconName: String?
    let iconSize: CGFloat?
    let iconVerticalPadding: CGFloat?
    let iconLeadingPadding: CGFloat?
    let iconTrailingPadding: CGFloat?
    let label: String
    let labelFont: Font
    let foregrounColor: Color
    let foregroundInactiveColor: Color
    let callback: (() -> ())?
    
    public init(
        systemIconName: String? = nil,
        iconSize: CGFloat? = nil,
        iconVerticalPadding: CGFloat? = nil,
        iconLeadingPadding: CGFloat? = nil,
        iconTrailingPadding: CGFloat? = nil,
        label: String,
        labelFont: Font = Font.headline,
        foregrounColor: Color = Color.primary,
        foregroundInactiveColor: Color = Color.gray,
        callback: (() -> ())? = nil
    ) {
        self.systemIconName = systemIconName
        self.iconSize = iconSize
        self.iconVerticalPadding = iconVerticalPadding
        self.iconLeadingPadding = iconLeadingPadding
        self.iconTrailingPadding = iconTrailingPadding
        self.label = label
        self.labelFont = labelFont
        self.foregrounColor = foregrounColor
        self.foregroundInactiveColor = foregroundInactiveColor
        self.callback = callback
    }
    
    var icon: some View {
        Group {
            if let sfSymbolName = systemIconName {
                Image(systemName: sfSymbolName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:iconSize ?? 19, height: iconSize ?? 19)
                    .padding(.vertical, iconVerticalPadding)
                    .padding(.leading, iconLeadingPadding ?? 18)
                    .padding(.trailing, iconTrailingPadding ?? 13)
            }
        }
    }
    
    var buttonView: some View {
        HStack (spacing: 0){
            icon
            Text(label)
                .font(labelFont)
            Spacer()
        }
    }
    
    public var body: some View {
        Group {
            if let callback = callback {
                Button(action: {
                    callback()
                }) {
                    buttonView
                        .foregroundColor(foregrounColor)
                }
            }
            else {
                buttonView
                    .foregroundColor(foregroundInactiveColor)
            }
        }
    }
}

struct ActionSheetCardItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            VStack (spacing: 0){
                ActionSheetCardItem(systemIconName: "play", label: "Play") {
                    //
                }
                
                Divider()
                
                ActionSheetCardItem(systemIconName: "stop", label: "Stop") {
                    //
                }
                
                Divider()
                
                ActionSheetCardItem(systemIconName: "record.circle", label: "Record")
            }
            .background(Color.white)
        }
        .background(Color.gray)
    }
}
