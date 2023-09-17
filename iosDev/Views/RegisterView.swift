import SwiftUI
// This is the Register Page!
struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode 
    @EnvironmentObject var userManager: UserManager // refering to data model for the view
    
    //All state variables that will hold user data
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertTitle: String = "Error"
    @State private var alertMessage: String = ""

    var body: some View {
        VStack(spacing: 20) { // using vstack again here for register form
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
            
            Button("Register") { // Register button which will check if data entered was successful
                if validateFields() {
                    userManager.register(username: username, email: email, password: password) { success, error in
                        if success {
                            self.alertTitle = "Success" // user feedback
                            self.alertMessage = "You have successfully registered." // user feedback
                            self.showAlert = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // error handling, dismisses view if left on idel!
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

            .padding() // UI trick i learned to add space between elements
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK"))) // pop up message allowing user to click okay
        }
    }

    func validateFields() -> Bool {
        if username.isEmpty || email.isEmpty || password.isEmpty {
            alertTitle = "Error"
            alertMessage = "Please fill in all fields." // error handling to validate input
            showAlert = true
            return false
        }
        return true
    }
}


