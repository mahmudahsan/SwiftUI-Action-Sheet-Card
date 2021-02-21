//
//  ActionSheetCardItem.swift
//
//  Created by Mahmud Ahsan
//
import SwiftUI

public struct ActionSheetCardItem: View {
    let id = UUID()
    let icon: String // SF Symbol
    let label: String
    let callback: (() -> ())?
    
    public init(
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
