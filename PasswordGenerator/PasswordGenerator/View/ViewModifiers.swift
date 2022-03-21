//
//  ViewModifiers.swift
//  PasswordGenerator
//
//  Created by Jarvis Lam on 3/21/22.
//

import Foundation
import SwiftUI

extension View {
    func centerH() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
    
    func addNavigationView(title: String) -> some View {
        NavigationView {
            self
                .navigationTitle(title)
        }
    }
}
