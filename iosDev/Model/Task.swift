//
//  Task.swift
//  iosDev
//
//  Created by Isabelle Brian on 12/9/2023.
//

import Foundation

struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isComplete: Bool = false
    var date: Date
}
