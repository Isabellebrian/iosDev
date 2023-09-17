//
//  CategoryView.swift
//  iosDev
//
//  Created by Isabelle Brian on 17/9/2023.
//

import SwiftUI

struct CategoryView: View {
    let category: Task.Category // constant cateogry this is what is used in List view to store different types of tasks in the right category.
    let tasks: [Task] // array storing tasks obj

    var body: some View {
        Section(header: Text(category.rawValue)) {
            ForEach(tasks) { task in
                Text(task.title) // Title of each category
            }
        }
    }
}
