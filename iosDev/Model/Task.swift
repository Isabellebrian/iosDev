//
//  Task.swift
//  iosDev
//
//  Created by Isabelle Brian on 12/9/2023.
//

import Foundation

// this structure repesents the Task entity in the data model that i have created, along with all the attributes
struct Task: Identifiable, Encodable {
    var id = UUID()
    var title: String
    var isComplete: Bool = false
    var date: Date
    var Category: Category
    
    
    enum Category: String, CaseIterable, Encodable {
        
        //Task types, which is displayed in AddTaskView sheet 
            case personal = "Personal"
            case food = "Food"
            case admin = "Admin"
            case purchases = "Purchases"
        }
}
