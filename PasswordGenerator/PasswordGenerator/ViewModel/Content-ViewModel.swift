//
//  Content-ViewModel.swift
//  PasswordGenerator
//
//  Created by Jarvis Lam on 3/21/22.
//

import Foundation
import SwiftUI

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var passwords: [Password] = []
        @Published var containsSymbols = true
        @Published var containsUppercase = false
        @Published var length = 10
        
        init () {
            createPassword()
        }
        
        func createPassword() {
            let alphabet = "abcdefghijklmnopqrstuvwxyz"
            var base = alphabet + "1234567890"
            var newPassword = ""
            
            if containsSymbols {
                base += "!@#$%^&*()_+-={}|\';<>?/.,"
            }
            
            if containsUppercase {
                base += alphabet.uppercased()
            }
            
            for _ in 0..<length {
                let randChar = base.randomElement()!
                newPassword += String(randChar)
            }
            
            let password = Password(passward: newPassword, containsSymbols: containsSymbols, containsUppercase: containsUppercase)
            withAnimation {
                passwords.insert(password, at: 0)
            }
        }
    }
}
