//
//  ListView.swift
//  iosDev
//
//  Created by Isabelle Brian on 14/9/2023.
//
import SwiftUI

struct ListView: View {
    @State private var tasks: [Task] = [] // keeps all tasks made by users
    @State private var showingAddTask = false // keeps display of task on false first

    var body: some View {
        NavigationView { // Navigation view structure again here to display the tasks
            List {
                ForEach(Task.Category.allCases, id: \.self) { category in // for loop, goes through each task that has been created. Similar to Reminder list
                    Section(header: Text(category.rawValue)) {
                        ForEach(tasks.filter { $0.Category == category }) { task in
                            Text(task.title)
                        }
                        .onDelete(perform: { indexSet in // adding the onDelete modifier to allow for the deletion of tasks by users
                            deleteTask(at: indexSet, for: category)
                        })
                    }
                }
            }
            .listStyle(InsetGroupedListStyle()) // modifier for list styling, using a simple list style
            .navigationTitle("Tasks") // View title
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddTask.toggle()
                }) {
                    Image(systemName: "plus") // Allows users to add a new task
                }
            )
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(tasks: $tasks)
            }
        }
    }

    func deleteTask(at offsets: IndexSet, for category: Task.Category) { // Delete function
        for index in offsets {
            if let matchedIndex = tasks.firstIndex(where: { $0.id == tasks.filter { $0.Category == category }[index].id }) {
                tasks.remove(at: matchedIndex) // removes index from Tasks mentioned earlier 
            }
        }
    }
}
