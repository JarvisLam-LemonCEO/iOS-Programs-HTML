//
//  ContentView.swift
//  MatrixRain
//
//  Created by Jarvis Lam on 2/5/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black
            
            MatrixrainView()
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
