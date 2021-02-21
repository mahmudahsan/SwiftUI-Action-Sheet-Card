/**
 *  GreyOutOfFocusView
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

public struct GreyOutOfFocusView: View {
    let opacity: CGFloat
    let callback: (() -> ())?
    
    public init(
        opacity: CGFloat = 0.7,
        callback: (() -> ())? = nil
    ) {
        self.opacity = opacity
        self.callback = callback
    }
    
    var greyView: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color.gray)
            .opacity(0.7)
            .onTapGesture {
                callback?()
            }
            .ignoresSafeArea()
    }
    
    public var body: some View {
        greyView
    }
}

struct GreyOutOfFocusView_Previews: PreviewProvider {
    static var previews: some View {
        GreyOutOfFocusView()
    }
}
