//
//  AppView.swift
//  iosDev
//
//  Created by Isabelle Brian on 16/9/2023.
//
import SwiftUI

struct AppView: View {
    @EnvironmentObject var userManager: UserManager // Assuming you have an environment object for user management

    var body: some View {
        Group {
            if userManager.isLoggedIn {
                ContentView()
            } else {
                Main()
            }
        }
    }
}
