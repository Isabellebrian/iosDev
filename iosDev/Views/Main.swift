import SwiftUI

struct Main: View {
    @EnvironmentObject var userManager: UserManager
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showRegister: Bool = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @State private var showReminderView: Bool = false

    var body: some View {
        
                
        
        NavigationView {
            ScrollView {
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

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                    Button("Login") {
                        if validateFields() {
                            userManager.login(username: username, password: password) { success, error in
                                if success {
                                    self.userManager.isAuthenticated = true
                                    // other related logic...
                                } else if let error = error {
                                    self.errorMessage = error
                                    self.showErrorAlert = true
                                }
                            }
                        }
                    }

                  
                    .padding()

                    NavigationLink(
                        destination: ReminderListView().environmentObject(userManager), // Pass userManager here
                        isActive: $showReminderView
                    ) {
                        EmptyView()
                    }

                    NavigationLink("Register", destination: RegisterView())
                }
                .padding()
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            

        }
        
      
    }
       
    func validateFields() -> Bool {
        if username.isEmpty || password.isEmpty {
            errorMessage = "Please fill in all fields."
            showErrorAlert = true
            return false
        }
        return true
    }
}

