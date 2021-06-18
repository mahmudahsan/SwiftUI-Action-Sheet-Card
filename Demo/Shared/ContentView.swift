//
//  ContentView.swift
//  Shared
//
//  Created by Mahmud Ahsan
//

import SwiftUI

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
        ActionSheetCard(
            isShowing: $showingSheet,
            items: [
                ActionSheetCardItem(systemIconName: "play", label: "Play") {
                    print("Play Tapped")
                    showingSheet = false
                },
                ActionSheetCardItem(systemIconName: "stop", label: "Stop", foregrounColor: Color.red) {
                    print("Stop Tapped")
                    showingSheet = false
                },
                ActionSheetCardItem(systemIconName: "record.circle", label: "Record")
            ],
            outOfFocusOpacity: 0.2,
            itemsSpacing: 2
        )
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
