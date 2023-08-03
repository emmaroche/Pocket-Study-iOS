//
//  AccountView.swift
//  PocketStudy
//
//  Created by Emma Roche on 14/07/2023.
//

import SwiftUI

struct AccountView: View {
    
    @AppStorage("Log_Status") var status = false
    
    var body: some View {
        ZStack{
            if status{}
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
