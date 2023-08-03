//
//  HomeView.swift
//  PocketStudy
//
//  Created by Emma Roche on 03/08/2023.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @AppStorage("Log_Status") var status = false
    @StateObject var modelData = Model()
    
    var body: some View {
        ZStack{
            if status{
                VStack(spacing: 25){
                    Text("Hello, logged in as \(Auth.auth().currentUser?.email ?? "")")
                    
                    Button(action: modelData.logOut, label: {
                        Text("Log out")
                            .foregroundColor(Color.black)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.white)
                            .cornerRadius(12)
                    })
                    
                }        .navigationBarBackButtonHidden(true)
                 
            }
            else {
                LoginScreen()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
