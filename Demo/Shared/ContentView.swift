//
//  ContentView.swift
//  Shared
//
//  Created by Mahmud Ahsan
//

import SwiftUI
import ActionSheetCard

struct ContentView: View {
    @State var showingSheet = false
    
    var content: some View {
        VStack {
            Text("Custom Sheet")
                .font(.largeTitle)
                .padding()
            Button(action: {
                showingSheet = true
            }) {
                Text("Open Sheet")
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var sheetView: some View {
        ActionSheetCard(isShowing: $showingSheet,
                        items: [
                            ActionSheetCardItem(sfSymbolName: "play", label: "Play") {
                                print("Play Tapped")
                                showingSheet = false
                            },
                            ActionSheetCardItem(sfSymbolName: "stop", label: "Stop", foregrounColor: Color.red) {
                                print("Stop Tapped")
                                showingSheet = false
                            },
                            ActionSheetCardItem(sfSymbolName: "record.circle", label: "Record")
                        ])
    }
    
    var body: some View {
        ZStack {
            content
            sheetView
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
