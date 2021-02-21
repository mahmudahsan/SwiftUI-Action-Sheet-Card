/**
 *  ActionSheetCard
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
import Combine

public struct ActionSheetCard: View {
    @State var offset = UIScreen.main.bounds.height
    @Binding var isShowing: Bool
    
    let items: [ActionSheetCardItem]
    let heightToDisappear = UIScreen.main.bounds.height
    let cellHeight: CGFloat = 50
    let backgroundColor: Color
    
    public init(
        isShowing: Binding<Bool>,
        items: [ActionSheetCardItem],
        backgroundColor: Color = Color.white
    ) {
        _isShowing = isShowing
        self.items = items
        self.backgroundColor = backgroundColor
    }
    
    func hide() {
        offset = heightToDisappear
        isShowing = false
    }
        
    var topHalfMiddleBar: some View {
        Capsule()
            .frame(width: 130, height: 5)
            .foregroundColor(Color.gray)
            .padding(.top, 20)
    }
    
    var itemsView: some View {
        VStack {
            ForEach(0..<items.count) { index in
                if index > 0 {
                    Divider()
                }
                items[index]
                    .frame(height: cellHeight)
            }
        }
        .padding()
    }
    
    var interactiveGesture: some Gesture {
        DragGesture()
            .onChanged({ (value) in
                if value.translation.height > 0 {
                    offset = value.location.y
                }
            })
            .onEnded({ (value) in
                let diff = abs(offset-value.location.y)
                if diff > 100 {
                    hide()
                }
                else {
                    offset = 0
                }
            })
    }
    
    var outOfFocusArea: some View {
        Group {
            if isShowing {
                GreyOutOfFocusView {
                    self.isShowing = false
                }
            }
        }
    }
    
    var sheetView: some View {
        VStack {
            Spacer()
            
            VStack {
                topHalfMiddleBar
                itemsView
                Text("").frame(height: 20) // empty space
            }
            .background(backgroundColor)
            .cornerRadius(15)
            .offset(y: offset)
            .gesture(interactiveGesture)
            .onTapGesture {
                hide()
            }
        }
    }
    
    var bodyContet: some View {
        ZStack {
            outOfFocusArea
            sheetView
        }
    }
    
    public var body: some View {
        Group {
            if isShowing {
                bodyContet
            }
        }
        .animation(.default)
        .onReceive(Just(isShowing), perform: { isShowing in
            offset = isShowing ? 0 : heightToDisappear
        })
    }
}

struct ActionSheetCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ActionSheetCard(isShowing: .constant(true),
                            items: [
                                ActionSheetCardItem(sfSymbolName: "play", label: "Play") {
                                    //
                                },
                                ActionSheetCardItem(sfSymbolName: "stop", label: "Stop") {
                                    //
                                },
                                ActionSheetCardItem(sfSymbolName: "record.circle", label: "Record")
                            ])
        }
    }
}
