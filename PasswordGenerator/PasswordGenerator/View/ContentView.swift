//
//  ContentView.swift
//  PasswordGenerator
//
//  Created by Jarvis Lam on 3/21/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        Form {
            Section("Options") {
                Toggle("Symbols", isOn: $vm.containsSymbols)
                Toggle("Uppercase", isOn: $vm.containsUppercase)
                Stepper("Character count: \(vm.length)", value: $vm.length, in: 6...30)
                Button("Generate Password", action: vm.createPassword)
                    .centerH()
            }
            Section("Password") {
                List(vm.passwords) {password in
                    HStack {
                        Text("\(password.passward)")
                            .padding()
                            .textSelection(.enabled)
                        Spacer()
                        Image(systemName: "lock.fill")
                            .foregroundColor(password.strengthColor)
                    }
                }
            }
        }
        .addNavigationView(title: "Lemon Password")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
