import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userManager: UserManager
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertTitle: String = "Error"
    @State private var alertMessage: String = ""

    var body: some View {
        VStack(spacing: 20) {
            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            Button("Register") {
                if validateFields() {
                    userManager.register(username: username, email: email, password: password) { success, error in
                        if success {
                            self.alertTitle = "Success"
                            self.alertMessage = "You have successfully registered."
                            self.showAlert = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        } else if let error = error {
                            self.alertTitle = "Error"
                            self.alertMessage = error
                            self.showAlert = true
                        }
                    }
                }
            }

            .padding()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func validateFields() -> Bool {
        if username.isEmpty || email.isEmpty || password.isEmpty {
            alertTitle = "Error"
            alertMessage = "Please fill in all fields."
            showAlert = true
            return false
        }
        return true
    }
}


