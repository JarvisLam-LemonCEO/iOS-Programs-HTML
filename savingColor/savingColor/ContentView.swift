//
//  ContentView.swift
//  savingColor
//
//  Created by Jarvis Lam on 3/1/22.
//

import SwiftUI

struct ColorData {
    private var COLOR_KEY = "COLOR_KEY"
    private let userDefualts = UserDefaults.standard
    
    func saveColor(color: Color){
        let color = UIColor(color).cgColor
        
        if let components = color.components{
            userDefualts.set(components, forKey: COLOR_KEY)
            print(components)
            print("Colors saved!!!")
        }
    }
    
    func loadColor() -> Color{
        guard let array = userDefualts.object(forKey: COLOR_KEY) as?
                [CGFloat] else {return Color.black}
        
        let color = Color(.sRGB, red: array[0], green: array[1], blue: array[2], opacity: array[3])
        
        print(color)
        print("Color loaded")
        return color
    }
}

struct ContentView: View {
    @State private var color: Color = Color.black
    private var colorData = ColorData()
    
    var body: some View {
        VStack(spacing: 10){
            ColorPicker("Pick a color", selection: $color)
            
            Rectangle()
                .frame(height: 200)
                .foregroundColor(color)
                .cornerRadius(20)
                .padding()
            
            Button("Save color") {
                colorData.saveColor(color: color)
            }
            Spacer()
                .onAppear{
                    color = colorData.loadColor()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
