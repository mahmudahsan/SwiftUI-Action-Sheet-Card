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
    let sfSymbolName: String?
    let label: String
    let labelFont: Font
    let foregrounColor: Color
    let callback: (() -> ())?
    
    public init(
        sfSymbolName: String? = nil,
        label: String,
        labelFont: Font = Font.headline,
        foregrounColor: Color = Color.primary,
        callback: (() -> ())? = nil
    ) {
        self.sfSymbolName = sfSymbolName
        self.label = label
        self.labelFont = labelFont
        self.foregrounColor = foregrounColor
        self.callback = callback
    }
    
    var buttonView: some View {
        HStack {
            if let sfSymbolName = sfSymbolName {
                Image(systemName: sfSymbolName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:19, height: 19)
                    .padding(.vertical)
                    .padding(.horizontal, 10)
            }
            
            Text(label)
                .font(labelFont)
            
            Spacer()
        }
        .foregroundColor(foregrounColor)
    }
    
    public var body: some View {
        Group {
            if let callback = callback {
                Button(action: {
                    callback()
                }) {
                    buttonView
                        .foregroundColor(Color.primary)
                }
            }
            else {
                buttonView
                    .foregroundColor(Color.gray)
            }
        }
    }
}
