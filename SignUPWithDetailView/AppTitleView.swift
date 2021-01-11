//
//  AppTitleView.swift
//  SignUPWithDetailView
//
//  Created by Knoxpo MacBook Pro on 11/01/21.
//

import SwiftUI

struct AppTitleView: View {
    var Title: String
    var body: some View {
        VStack{
            
            VStack(alignment: .leading) {
             
                Text("FirebaseLogin").font(.system(size: 24)).fontWeight(.ultraLight).frame(width: 0, height: 100, alignment: .topLeading)
                
                Text(Title).font(.system(size: 42)).fontWeight(.light)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .leading)
                
            }
            
            
            
            
        }
        .padding(.top, 30).padding(.leading,10).background(Color.init(red: 0.9, green: 0.9, blue: 0.9)).shadow(radius: 21 )
        
    }
}

struct AppTitleView_Previews: PreviewProvider {
    static var previews: some View {
        AppTitleView(Title: "Example")
    }
}
