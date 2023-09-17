//
//  AddTaskView.swift
//  iosDev
//
//  Created by Isabelle Brian on 17/9/2023.
//

import SwiftUI


struct AddTaskView: View {
    @Binding var tasks: [Task]
    @State private var title: String = ""
    @State private var selectedCategory: Task.Category = .personal
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $title)
                Picker("Category", selection: $selectedCategory) {
                    ForEach(Task.Category.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                Button("Add Task") {
                    let newTask = Task(title: title, date: Date(), Category: selectedCategory)
                    tasks.append(newTask)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
