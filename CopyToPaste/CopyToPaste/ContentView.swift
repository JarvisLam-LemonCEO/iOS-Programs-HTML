//
//  ContentView.swift
//  CopyToPaste
//
//  Created by Jarvis Lam on 4/8/22.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    @State private var buttonText: String = "Copt to clipboard"
    private let pasteboard = UIPasteboard.general
    
    var body: some View {
        VStack {
            TextField("Insert text here", text: $text)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Button {
                    coptToClipboard()
                } label: {
                    Label(buttonText, systemImage: "doc.on.doc.fill")
                }
                Spacer()
                Button {
                    paste()
                } label: {
                    Label("Paste", systemImage: "doc.on.clipboard")
                }
                .tint(.orange)
            }
        }
            .padding()
            
        }
        
        func paste() {
            if let string = pasteboard.string {
                text = string
            }
        }
    
        func coptToClipboard() {
            pasteboard.string = self.text
            self.text = ""
            self.buttonText = "Copied"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.buttonText = "Copy to clipboard"
            }
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
