# ActionSheetCard
<p align="center">
    <a href="https://github.com/mahmudahsan/SwiftUI-Action-Sheet-Card">
        <img src="https://img.shields.io/badge/platform-iOS-lightgrey" alt="iOS" />
    </a>
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/spm-compatible-green.svg?style=flat" alt="Swift Package Manager" />
    </a>
    <a href="https://twitter.com/mahmudahsan">
        <img src="https://img.shields.io/twitter/url?url=https%3A%2F%2Fgithub.com%2Fmahmudahsan%2FSwiftUI-Action-Sheet-Card" alt="Tweet" />
    </a>
    
</p>

A SwiftUI based custom sheet card to reuse in iOS application.

 <p align="center">
    <img src="Resources/demo.gif" width="320" alt="Demo" />
</p>

## Features
- Customizable items within the sheet card
- Font can be changed
- Foreground and background color can be changed

## How to use

Add this Swift package to your project
```
https://github.com/mahmudahsan/SwiftUI-Action-Sheet-Card
```

 <p align="center">
    <img src="Resources/spm-add.png" width="320" alt="Demo" />
</p>

#### Import and use

```swift
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
```
#### Steps
1. Add `import ActionSheetCard` in your SwiftUI View
2. Define a `@State var showingSheet = false` state
3. Create the sheet view and pass the state and define some items
```Swift
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
```
4. Use the sheet in your main view
```Swift
var body: some View {
        ZStack {
            content
            sheetView
        }
    }
```

**For more examples open `/Demo/Demo.xcodeproj`**

## Questions or feedback?

- Feel free to [open an issue](https://github.com/mahmudahsan/SwiftUI-Action-Sheet-Card/issues/new)
- Find me [@mahmudahsan on Twitter](https://twitter.com/mahmudahsan)
- Read programming articles on [Level Up Programming](https://levelupprogramming.net/)