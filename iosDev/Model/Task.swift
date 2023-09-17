//
//  Task.swift
//  iosDev
//
//  Created by Isabelle Brian on 12/9/2023.
//

import Foundation

struct Task: Identifiable, Encodable {
    var id = UUID()
    var title: String
    var isComplete: Bool = false
    var date: Date
    var Category: Category
    
    
    enum Category: String, CaseIterable, Encodable {
            case personal = "Personal"
            case food = "Food"
            case admin = "Admin"
            case purchases = "Purchases"
        }
}
