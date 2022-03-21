//
//  PasswordModel.swift
//  PasswordGenerator
//
//  Created by Jarvis Lam on 3/21/22.
//

import Foundation
import SwiftUI

struct Password: Identifiable, Codable {
    var id = UUID()
    var passward: String
    var containsSymbols: Bool
    var containsUppercase: Bool
    
    var strengthColor: Color {
        var strength = 0
        var color: Color
        
        if containsSymbols {
            strength += 1
        }
        
        if containsUppercase {
            strength += 1
        }
        
        if passward.count > 12 {
            strength += 1
        } else if passward.count < 8 {
            strength -= 1
        }
        
        switch strength {
        case 1: color = .green
        case 2: color = .yellow
        case 3: color = .red
        default: color = .gray
        }
        
        return color
    }
}
