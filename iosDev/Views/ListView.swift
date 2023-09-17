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
                    CategoryView(category: category, tasks: tasks.filter { $0.Category == category })
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
}
