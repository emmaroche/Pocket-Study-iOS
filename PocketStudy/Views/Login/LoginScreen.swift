//
//  LoginScreen.swift
//  PocketStudy
//
//  Created by Emma Roche on 12/07/2023.
//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var modelData = Model()
    
    var body: some View {
        
            VStack{
                
              
                Image("PSLOGOBIG")
                    .resizable()
                    .frame(width: 180, height: 180)
                    .padding(.bottom, 20)
                    .padding(.top, -10)
            
                    
                    Text("Sign In")
                        .font(.system(size: UIScreen.main.bounds.width * 0.06))
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                
                
                Text("Elevate your study game with Pocket Study!")
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    .fontWeight(.semibold)
                    .font(.system(size: UIScreen.main.bounds.width * 0.04))
                    .multilineTextAlignment(.center)
       
                VStack(spacing: 4){
                    
                    HStack(spacing: 0) {
                        Text("Email")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTextField(image: "envelope.fill", placeHolderText: "Enter Email Address", text: $modelData.email)
                        .padding(.bottom, 15)
                    
                    
                    HStack(spacing: 0) {
                        Text("Password")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTextField(image: "lock.fill", placeHolderText: "Enter Password", text: $modelData.password)   .padding(.bottom, 5)
                    
                    HStack(spacing: 0) {
                        Button(action: {}) {
                            Text("Forgot Password?")
                                .font(.system(size: 16))
                                .foregroundColor(Color.black)
                            
                        }
                    }
                    .padding(.horizontal, 30)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                
                Button(action: {}) {

                    Text("Log In")
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .cornerRadius(12)


                }.padding(.top, 20)
            
                
                HStack{
                    Text("Don't have an account?")
//                    Button(action: {modelData.signUp.toggle()}) {
//
//                        Text("Sign Up Now")
//                            .fontWeight(.bold)
//                            .foregroundColor(Color.white)
//                    }
                    
                    NavigationLink(destination: RegisterScreen()) {
                        Text("Sign Up Now")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                       
                }.padding(.top, 30)
                
                
                Spacer()
                
            }.padding(.vertical, 30)
                .background(CustomColour.DefaultOrange)
                .fullScreenCover(isPresented: $modelData.signUp) {
                    RegisterScreen(modelData: modelData)
                }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

struct CustomTextField: View {
    
    var image : String
    var placeHolderText : String
    @Binding var text : String
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            ZStack{
                if placeHolderText == "Enter Password"{
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


class Model : ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    @Published var signUp = false
    @Published var signIn = false
                
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
