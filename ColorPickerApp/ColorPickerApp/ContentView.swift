//
//  ContentView.swift
//  ColorPickerApp
//
//  Created by Jarvis Lam on 3/27/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedColor: Color = .red
    
    var body: some View {
        VStack{
            CustomeColorPicker(selectedColor: $selectedColor)
            Spacer()
            Circle()
                .frame(width: 300, height: 300)
                .foregroundColor(selectedColor)
            Text("\(selectedColor.description)")
                .font(.system(size: 40))
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
