//
//  ContentView.swift
//  SwipeDownRefresh
//
//  Created by Jarvis Lam on 12/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var items: Int = 1
    @State private var randomNumbers: [Int] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(randomNumbers, id: \.self) { item in
                    let color = item == randomNumbers.max() ? Color.green : Color.black
                    
                    Text("\(item)")
                        .foregroundColor(color)
                        .bold()
                        .padding()
                }
            }
            .navigationTitle("Random Number")
            .onAppear(perform: getRandomNumbers)
            .refreshable {
                getRandomNumbers()
            }
        }
    }
    
    func getRandomNumbers() {
        randomNumbers = []
        
        for i in 1...10 {
            let randNum = Int.random(in: 0...100)
            randomNumbers.append(randNum)
        }
        randomNumbers.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
