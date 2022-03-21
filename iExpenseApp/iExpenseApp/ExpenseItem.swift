//
//  ExpenseItem.swift
//  iExpenseApp
//
//  Created by Jarvis Lam on 1/1/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

