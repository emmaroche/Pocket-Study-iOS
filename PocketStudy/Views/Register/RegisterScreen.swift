//
//  RegisterScreen.swift
//  PocketStudy
//
//  Created by Emma Roche on 12/07/2023.
//

import SwiftUI

struct RegisterScreen: View {
    
    @StateObject var modelData = Model()
    
    var body: some View {
        
        ZStack{
            VStack{
                
                Text("Sign Up")
                    .font(.system(size: UIScreen.main.bounds.width * 0.06))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                
                Text("Unlock a world of organised and efficient studying, tailored to your unique study goals!")
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    .fontWeight(.semibold)
                    .font(.system(size: UIScreen.main.bounds.width * 0.04))
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 4){
                    
                    HStack(spacing: 0) {
                        Text("Name")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTextFieldRegister(image: "person.fill", placeHolderText: "Enter Name", text: $modelData.name)
                        .padding(.bottom, 15)
                    
                    HStack(spacing: 0) {
                        Text("Email")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTextFieldRegister(image: "envelope.fill", placeHolderText: "Enter Email Address", text: $modelData.emailSignUp)
                        .padding(.bottom, 15)
                    
                    HStack(spacing: 0) {
                        Text("Password")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTextFieldRegister(image: "lock.fill", placeHolderText: "Enter Password", text: $modelData.passwordSignUp)   .padding(.bottom, 15)
                    
                    HStack(spacing: 0) {
                        Text("Re-Enter Password")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTextFieldRegister(image: "lock.fill", placeHolderText: "Re-Enter Password", text: $modelData.passwordConfirm)
                    
                }
                
                Button(action: modelData.register) {
                    
                    Text("Sign Up")
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .cornerRadius(12)
                    
                    
                }.padding(.top, 40)
                
                
                Spacer()
                
            }
            
            if modelData.isLoading{
                LoadingView()
            }
        }
        .background(CustomColour.DefaultOrange)
        .navigationBarItems(leading: CustomBackButton())
        .navigationBarBackButtonHidden(true)
        
        // Alerts
        
        .alert(isPresented: $modelData.alert, content: {
            Alert(title: Text("Message"), message: Text(modelData.alertMessage), dismissButton: .destructive(Text("Ok"), action: {
                if modelData.alertMessage == "Sign-Up Complete! Please Sign in to your new account." {
                
                    modelData.signUp.toggle()
                    modelData.name = ""
                    modelData.emailSignUp = ""
                    modelData.passwordSignUp = ""
                    modelData.passwordConfirm = ""
                }
                
            }))
        })
    }
}

struct CustomTextFieldRegister: View {
    
    var image : String
    var placeHolderText : String
    @Binding var text : String
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            ZStack{
                if placeHolderText == "Enter Password" || placeHolderText == "Re-Enter Password" {
                    SecureField(placeHolderText, text: $text)
                }else{
                    TextField(placeHolderText, text: $text)
                }
            }
            .padding(.horizontal)
            .padding(.leading, 45)
            .frame(height: 60)
            .background(Color.white)
            .cornerRadius(12)
            
            
            Image(systemName: image)
                .font(.system(size: 24))
                .foregroundColor(CustomColour.DefaultBlue)
                .frame(width: 60, height: 60)
                .background(Color.white)
                .clipShape(Circle())
            
                        
        }.padding(.horizontal)
        
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
