//
//  CategoryView.swift
//  iosDev
//
//  Created by Isabelle Brian on 17/9/2023.
//

import SwiftUI

struct CategoryView: View {
    let category: Task.Category
    let tasks: [Task]

    var body: some View {
        Section(header: Text(category.rawValue)) {
            ForEach(tasks) { task in
                Text(task.title)
            }
        }
    }
}
