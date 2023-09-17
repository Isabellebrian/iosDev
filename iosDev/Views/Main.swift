import SwiftUI

struct Main: View { // this is the main view aka Login page
    @EnvironmentObject var userManager: UserManager // adding Usermanager to the view
    
    //Using state , this keeps all the user data and alets to changes
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showRegister: Bool = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @State private var showReminderView: Bool = false

    var body: some View {
        
                
        
        NavigationView { // navigation wraos around the stack, common practice with SwiftUI
            ScrollView { // i implemented the scroll view   HOWEVER IT DOES NOT WORK, I am unsure why i have debugged it but have not be able to identify the cause . I cannot scroll through the reminder page
                VStack { // vertical stack, since the app is in portrait mode, i used this stack to help me align text, textfield and button
                    Text("Family Scheduler") // app name
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.blue)

                    TextField("Username", text: $username) // text field for users to enter username
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .autocapitalization(.none)

                    SecureField("Password", text: $password) // secure field which covers the users password when typing it in
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                    Button("Login") { // UI button allows for user to enter the information, different from UIKit, had issues with assigning a button 
                        if validateFields() {
                            userManager.login(username: username, password: password) { success, error in
                                if success {
                                    self.userManager.isAuthenticated = true
                                   
                                } else if let error = error {
                                    self.errorMessage = error // error handling , if unsucessful login
                                    self.showErrorAlert = true
                                }
                            }
                        }
                    }

                  
                    .padding()

                    NavigationLink( // had some issues with implementing NavigationLink
                        destination: ReminderListView().environmentObject(userManager), // Pass userManager
                        isActive: $showReminderView
                    ) {
                        EmptyView()
                    }

                    NavigationLink("Register", destination: RegisterView()) // If user presses register button taken to register view
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
            errorMessage = "Please fill in all fields." // error handling if user does not fill out all text field before loggin in /register 
            showErrorAlert = true
            return false
        }
        return true
    }
}

