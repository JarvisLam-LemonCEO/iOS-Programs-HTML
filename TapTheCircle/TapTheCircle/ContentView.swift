//
//  ContentView.swift
//  TapTheCircle
//
//  Created by Jarvis Lam on 12/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var color = Color.gray
    @State private var tutorialText = "(Tap the circle)"
    
    
    var body: some View {
        VStack {
            Text(tutorialText)
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(color)
            // count means tap twice
                .onTapGesture(count: 2) {
                    self.color = Color.red
                    self.tutorialText = "Isn't that cool?"
                }
                .onTapGesture(count: 1) {
                    self.color = Color.green
                    self.tutorialText = "Now try tapping it twice"
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
