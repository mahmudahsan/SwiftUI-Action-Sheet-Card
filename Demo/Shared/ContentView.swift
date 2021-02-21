//
//  ContentView.swift
//  Shared
//
//  Created by Mahmud Ahsan on 21/2/21.
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
        VStack {
            Spacer()
            ActionSheetCard(isShowing: $showingSheet,
                            items: [
                                ActionSheetCardItem(icon: "play", label: "Play") {
                                    print("Play Tapped")
                                    showingSheet = false
                                },
                                ActionSheetCardItem(icon: "stop", label: "Stop") {
                                    print("Stop Tapped")
                                    showingSheet = false
                                },
                                ActionSheetCardItem(icon: "record.circle", label: "Record")
                            ])
        }
    }
    
    var sheetContainerView: some View {
        Group {
            if showingSheet {
                GreyOutOfFocusView {
                    self.showingSheet = false
                }
                sheetView
            }
        }
    }
    
    var body: some View {
        ZStack {
            content
            sheetContainerView
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
