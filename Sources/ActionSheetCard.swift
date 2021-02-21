//
//  Created by Mahmud Ahsan

import SwiftUI
import Combine

public struct ActionSheetCardItem: View {
    let id = UUID()
    let icon: String // SF Symbol
    let label: String
    let callback: (() -> ())?
    
    init(
        icon: String,
        label: String,
        callback: (() -> ())? = nil
    ) {
        self.icon = icon
        self.label = label
        self.callback = callback
    }
    
    var buttonView: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:19, height: 19)
                .padding(.vertical)
                .padding(.horizontal, 10)
            Text(label)
                .font(.headline)
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

public struct ActionSheetCard: View {
    @State var offset = UIScreen.main.bounds.height
    
    @Binding public var isShowing: Bool
    public let items: [ActionSheetCardItem]
    
    let heightToDisappear = UIScreen.main.bounds.height
    let cellHeight: CGFloat = 50
    
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
    
    public var body: some View {
        ZStack {
            VStack {
                topHalfMiddleBar
                itemsView
                Text("").frame(height: 20) // empty space
            }
            .background(Color.white)
            .cornerRadius(15)
            .offset(y: offset)
            .gesture(interactiveGesture)
            .onTapGesture {
                hide()
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
                                ActionSheetCardItem(icon: "play", label: "Play") {
                                    //
                                },
                                ActionSheetCardItem(icon: "stop", label: "Stop") {
                                    //
                                },
                                ActionSheetCardItem(icon: "record.circle", label: "Record")
                            ])
        }
    }
}
