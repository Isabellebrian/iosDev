//
//  TaskViewModel.swift
//  iosDev
//
//  Created by Isabelle Brian on 16/9/2023.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
}
