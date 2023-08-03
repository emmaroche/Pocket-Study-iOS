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
        ZStack{
            VStack {
                Image("PSLOGOBIG")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: UIScreen.main.bounds.width * 0.5)
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
                
                VStack(spacing: 4) {
                    HStack {
                        Text("Email")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.bottom, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    
                    CustomTextField(image: "envelope.fill", placeHolderText: "Enter Email Address", text: $modelData.email)
                        .padding(.bottom, 15)
                    
                    HStack {
                        Text("Password")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.bottom, 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    
                    CustomTextField(image: "lock.fill", placeHolderText: "Enter Password", text: $modelData.password)
                        .padding(.bottom, 5)
                    
                    HStack {
                        Button(action: { modelData.resetYourPassword() }) {
                            Text("Forgot Password?")
                                .font(.system(size: 14))
                                .foregroundColor(Color.black)
                        }
                        .padding(.trailing, 0)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                }
                
                NavigationLink(destination: HomeView()) {
                    Button(action: modelData.login) {
                        Text("Log In")
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                    
                }.padding(.top, 30)
                
                HStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: RegisterScreen()) {
                        Text("Sign Up Now")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.top, 30)
                
                Spacer()
            }
            
            if modelData.isLoading{
                LoadingView()
            }

        }
        .background(CustomColour.DefaultOrange)
        .alert(isPresented: $modelData.linkSent) {
            Alert(title: Text("Message"), message: Text("Password Reset Link has been sent"), dismissButton: .destructive(Text("Ok")))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        
        // Alerts
        
        .alert(isPresented: $modelData.alert, content: {
            Alert(title: Text("Message"), message: Text(modelData.alertMessage), dismissButton: .destructive(Text("Ok")))
        })
        
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

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        

            LoginScreen()
                .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            
                .previewDisplayName("iPhone 14")
            
            LoginScreen()
                .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
                .previewDisplayName("iPhone 14 Pro Max")
            
            LoginScreen()
                .previewDevice(PreviewDevice(rawValue: "13 mini"))
                .previewDisplayName("13 mini")
            
        
    }
}
