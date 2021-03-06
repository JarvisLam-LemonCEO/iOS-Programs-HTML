//
//  ContentView.swift
//  ProgressSpinner
//
//  Created by Jarvis Lam on 12/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showLoading = false
    @State private var status = "Downloading..."
    @State private var data = 0.0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            Spacer()
            if showLoading {
                ProgressView("Loading")
            } else {
                ProgressView("\(status)", value: data, total: 100)
                    .onReceive(timer) {_ in
                        if data < 100 {
                            data += Double.random(in: 0...4)
                        } else {
                            status = "Done!"
                        }
                    }//.tint(Color.red)
            }
            
            Spacer()
            
            Toggle("Infinite", isOn: $showLoading.animation())
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
