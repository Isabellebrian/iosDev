//
//  ListView.swift
//  iosDev
//
//  Created by Isabelle Brian on 14/9/2023.
//
import SwiftUI

struct ListView: View {
    @State private var tasks: [Task] = []
    @State private var showingAddTask = false

    var body: some View {
        NavigationView {
            List {
                ForEach(Task.Category.allCases, id: \.self) { category in
                    Section(header: Text(category.rawValue)) {
                        ForEach(tasks.filter { $0.Category == category }) { task in
                            Text(task.title)
                        }
                        .onDelete(perform: { indexSet in
                            deleteTask(at: indexSet, for: category)
                        })
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Tasks")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddTask.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(tasks: $tasks)
            }
        }
    }

    func deleteTask(at offsets: IndexSet, for category: Task.Category) {
        for index in offsets {
            if let matchedIndex = tasks.firstIndex(where: { $0.id == tasks.filter { $0.Category == category }[index].id }) {
                tasks.remove(at: matchedIndex)
            }
        }
    }
}
