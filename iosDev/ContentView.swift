//
//  ContentView.swift
//  iosDev
//
//  Created by Isabelle Brian on 12/9/2023.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = TaskViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            // Further use the viewModel to show and modify tasks
            // ...
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
