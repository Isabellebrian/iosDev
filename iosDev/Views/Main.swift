

import SwiftUI

struct Main: View {
    @EnvironmentObject var userManager: UserManager
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @State private var showReminderView: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Family Scheduler")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.blue)

                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                Button("Login") {
                    userManager.login(username: username, password: password) { success, error in
                        if success {
                            self.showReminderView = true
                        } else if let error = error {
                            self.errorMessage = error
                            self.showErrorAlert = true
                        }
                    }
                }
                .padding()

                NavigationLink("Register", destination: RegisterView())
            }
            .padding()
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .background(NavigationLink("", destination: ReminderView(), isActive: $showReminderView).opacity(0))
        }
    }
}

