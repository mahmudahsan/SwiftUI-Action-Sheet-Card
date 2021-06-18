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
    @State var isDragging = false
    
    let items: [ActionSheetCardItem]
    let heightToDisappear = UIScreen.main.bounds.height
    let cellHeight: CGFloat = 50
    let backgroundColor: Color
    let outOfFocusOpacity: CGFloat
    let minimumDragDistanceToHide: CGFloat
    let itemsSpacing: CGFloat
    
    public init(
        isShowing: Binding<Bool>,
        items: [ActionSheetCardItem],
        backgroundColor: Color = Color.white,
        outOfFocusOpacity: CGFloat = 0.7,
        minimumDragDistanceToHide: CGFloat = 150,
        itemsSpacing: CGFloat = 0
    ) {
        _isShowing = isShowing
        self.items = items
        self.backgroundColor = backgroundColor
        self.outOfFocusOpacity = outOfFocusOpacity
        self.minimumDragDistanceToHide = minimumDragDistanceToHide
        self.itemsSpacing = itemsSpacing
    }
    
    func hide() {
        offset = heightToDisappear
        isDragging = false
        isShowing = false
    }
        
    var topHalfMiddleBar: some View {
        Capsule()
            .frame(width: 36, height: 5)
            .foregroundColor(Color.black)
            .padding(.vertical, 5.5)
            .opacity(0.2)
    }
    
    var itemsView: some View {
        VStack (spacing: itemsSpacing){
            ForEach(0..<items.count) { index in
                if index > 0 {
                    Divider()
                }
                items[index]
                    .frame(height: cellHeight)
            }
            Text("").frame(height: 40) // Extra empty space
        }
    }
    
    func dragGestureOnChange(_ value: DragGesture.Value) {
        isDragging = true
        if value.translation.height > 0 {
            offset = value.location.y
            let diff = abs(value.location.y - value.startLocation.y)
            
            let conditionOne = diff > minimumDragDistanceToHide
            let conditionTwo = value.location.y >= 200
            
            
            if conditionOne || conditionTwo {
                hide()
            }
        }
    }
    
    var interactiveGesture: some Gesture {
        DragGesture()
            .onChanged({ (value) in
                dragGestureOnChange(value)
            })
            .onEnded({ (value) in
                isDragging = false
            })
    }
    
    var outOfFocusArea: some View {
        Group {
            if isShowing {
                GreyOutOfFocusView(opacity: outOfFocusOpacity) {
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
    
    func onUpdateIsShowing(_ isShowing: Bool) {
        if isShowing && isDragging {
            return
        }
        
        DispatchQueue.main.async {
            offset = isShowing ? 0 : heightToDisappear
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
            onUpdateIsShowing(isShowing)
        })
    }
}

struct ActionSheetCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ActionSheetCard(isShowing: .constant(true),
                            items: [
                                ActionSheetCardItem(systemIconName: "play", label: "Play") {
                                    //
                                },
                                ActionSheetCardItem(systemIconName: "stop", label: "Stop") {
                                    //
                                },
                                ActionSheetCardItem(systemIconName: "record.circle", label: "Record")
                            ],
                            outOfFocusOpacity: 0.2
            )
        }
    }
}
