//
//  Main.swift
//  iosDev
//
//  Created by Isabelle Brian on 12/9/2023.
//

import SwiftUI

struct Main: View {
    @EnvironmentObject var userManager: UserManager
       @State private var username: String = ""
       @State private var email: String = ""


    var body: some View {
        VStack {
            Text("Family Scheduler") // This is your title text.
                .font(.largeTitle) // Makes the text larger, similar to a title.
                .padding() // Adds padding around the text.
                .foregroundColor(.blue)
            
            Spacer() // This pushes everything above it to the top.
            
            TextField("Username", text: $username)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            Button("Login") {
                    userManager.login(username: username, email: email)
                }
                .padding()
            
            // Registration form (similar to above but calls register instead)
            Button("Register") {
                userManager.register(username: username, email: email)
            }
            .padding()
        }
        .padding()    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
