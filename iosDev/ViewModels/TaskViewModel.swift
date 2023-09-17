//
//  TaskViewModel.swift
//  iosDev
//
//  Created by Isabelle Brian on 16/9/2023.
//

import Foundation

class TaskViewModel: ObservableObject { // handles a range of functions for the Task view 
    @Published var tasks: [Task] = []
    
    
    
    // Adding a new task
    func addTask(_ task: Task) {
        tasks.append(task)
       
    }

    // Deleting a task
    func deleteTask(at index: Int) {
        guard index >= 0 && index < tasks.count else { return }
        tasks.remove(at: index)
     
    }

    // Editing a task
    func editTask(at index: Int, with task: Task) {
        guard index >= 0 && index < tasks.count else { return }
        tasks[index] = task
      
    }

}
    

