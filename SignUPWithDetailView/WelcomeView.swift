//
//  WelcomeView.swift
//  SignUPWithDetailView
//
//  Created by Knoxpo MacBook Pro on 11/01/21.
//

import SwiftUI
import Firebase


public var screenwidth: CGFloat
{
    
    return UIScreen.main.bounds.width
}


public var screenHight: CGFloat
{
    return UIScreen.main.bounds.height
    
}
struct WelcomeView: View {
    @State var signUpIsPresent: Bool = false
    @State var signINisPresent: Bool = false
    @State var selection: Int? = nil
    @State var viewState = CGSize.zero
    @State var MainViewSTATE = CGSize.zero
    
    
    var body: some View {
        ZStack{
          if  Auth.auth().currentUser != nil {
                VStack{
                    AppTitleView(Title: "Home")
                    Spacer()
                    Text("Hello World")
                    Spacer()
                    
                    Button(action: {
                        self.signINisPresent = true
                        let firebaseAuth = Auth.auth()
                        do {
                            try firebaseAuth.signOut()
                            
                        }
                        catch let signOutError as
                                NSError{
                            
                            
                          //  print("\(signOutError)")
                        }
                        self.MainViewSTATE = CGSize(width: screenwidth, height: 0)
                        self.viewState = CGSize(width: 0, height: 0)
                        
                    }) {
                        Text("Sign Out")
                            .foregroundColor(Color.white)
                            .padding()
                    }
                    .sheet(isPresented: $signINisPresent) {
                        
                        SignInView(onDismiss: {print("Hi")})
                        
                    }
                    
                    
                    .background(Color.green)
                    .cornerRadius(5)
                    
                    
                }.edgesIgnoringSafeArea(.top)
                .background(Color.white)
                .offset(x: self.MainViewSTATE.width).animation(.spring())
                
                
                
            }
            
            
            else {
                
                VStack {
                    
                    AppTitleView(Title: "Welcome")
                   // Spacer()
                    VStack(spacing:20) {
                        
                        Button(action: {
                            
                            self.signUpIsPresent = true
                            
                            
                        })
                        {
                            Text("Sign UP")
                            
                        }.sheet(isPresented: self.$signUpIsPresent)
                            {
                            
                            SignUPView()
                        }
                        
                        Button(action: {
                            self.signINisPresent = true
                            
                        })
                        {
                            Text("Sign IN")
                            
                        }.sheet(isPresented: $signINisPresent) {
                            
                            SignInView(onDismiss:{
                                
                            self.viewState = CGSize(width: screenwidth, height: 0)
                            self.MainViewSTATE = CGSize(width: 0, height: 0)
                                
                            })}}
                    
                    
                    
                
                Spacer()
                
                
                
                
                
            }.edgesIgnoringSafeArea(.top)
            .background(Color.white)
            .offset(x: self.MainViewSTATE.width).animation(.spring())
           
            
            }
            
        }
            
        }
    }


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
