//
//  LoginModel.swift
//  PocketStudy
//
//  Created by Emma Roche on 12/07/2023.
//

// The following resource was used to assist with the development of this file: https://www.youtube.com/watch?v=ZZY42MDU5Aw&t=0s

import SwiftUI
import Firebase

class Model : ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var emailSignUp = ""
    @Published var passwordSignUp  = ""
    @Published var passwordConfirm = ""
    @Published var signUp = false
    @Published var signIn = false
    @Published var resetPassword = ""
    @Published var linkSent = false
    
    // Error Alerts
    
    @Published var alertMessage = ""
    @Published var alert = false
    
    // User Status
    
    @AppStorage("Log_Status") var status = false
    
    // Loading
    
    @Published var isLoading = false
    
    func resetYourPassword(){
    let alert = UIAlertController(title: "Reset password", message: "Enter your Email to Reset Your Password", preferredStyle: .alert)
        
        alert.addTextField{ (password) in
            
            password.placeholder = "Enter Email"
        
        }
        
        let proceed = UIAlertAction(title: "Reset", style: .default) { (_) in
            self.resetPassword = alert.textFields![0].text!
            
            self.linkSent.toggle()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
       alert.addAction(cancel)
       alert.addAction(proceed)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        
    }
    
    // Login with Firebase Authentication
    
    func login(){
      
            if email == "" || password == "" {
                self.alertMessage = "Please enter inputs to each text field"
                self.alert.toggle()
                return
            }
        
        withAnimation {
            self.isLoading.toggle()
        }
            
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            
            withAnimation {
                self.isLoading.toggle()
            }
               
            
            if err != nil {
                self.alertMessage = err!.localizedDescription
                self.alert.toggle()
                return
                
            }
            
            withAnimation{
                self.status = true
            }
            
        }
    }
    
    // Register with Firebase Authentication
    
    func register(){
        if name == "" || emailSignUp == "" || passwordSignUp == "" || passwordConfirm == ""{
            self.alertMessage = "Please enter inputs to each text field"
            self.alert.toggle()
            return
        }
        
        if  passwordSignUp != passwordConfirm {
            self.alertMessage = "Passwords don't match"
            self.alert.toggle()
            return
        }
        
        withAnimation {
            self.isLoading.toggle()
        }
            
        
        Auth.auth().createUser(withEmail: emailSignUp, password: passwordSignUp) {
            (result, err) in
            
            withAnimation {
                self.isLoading.toggle()
            }
                
            
            if err != nil {
                self.alertMessage = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            self.alertMessage = "Sign-Up Complete! Please Sign in to your new account."
            self.alert.toggle()
            
        }
 
    }
    
    // Log out
    
    func logOut(){
        
        try! Auth.auth().signOut()
        
        withAnimation {
            self.status = false
            name = ""
            emailSignUp = ""
            passwordSignUp = ""
            passwordConfirm = ""
        }
    }
    
                
}
