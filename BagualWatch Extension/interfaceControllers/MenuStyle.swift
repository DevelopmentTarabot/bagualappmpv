//
/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */


import SwiftUI

struct MenuStyle: ButtonStyle {
    var symbolName: String
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        VStack {
            Image(systemName: self.symbolName)
            .resizable()
            .frame(width: 60, height: 60, alignment: .center)
            Spacer().frame(width: 8, height: 8, alignment: .center)
            configuration.label
            .foregroundColor(.white)
            .font(Font.system(size: 14, weight: .regular, design: .default))
        }
    }
}

struct MenuButton: View {
    var title = "Resume"
    var symbolName = "pause.circle.fill"
    var action = { print("Menu button tapped!") }

    var body: some View {
            Button(action: { self.action() }) {
                    Text(self.title)
            }
            .buttonStyle(MenuStyle(symbolName: symbolName))
        }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        
                MenuButton(title: "End", symbolName: "xmark.circle.fill", action: {})

    }
}
