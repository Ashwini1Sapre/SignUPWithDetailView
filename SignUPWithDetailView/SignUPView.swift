//
//  SignUPView.swift
//  SignUPWithDetailView
//
//  Created by Knoxpo MacBook Pro on 11/01/21.
//

import SwiftUI
import Firebase

struct actINSignUp: UIViewRepresentable{
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if self.SholudAnimate {
            uiView.startAnimating()
        }
        else
        {
            uiView.stopAnimating()
        }
    }
    
    @Binding var SholudAnimate: Bool
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        
        return UIActivityIndicatorView()
    }
    
   
    
}



struct SignUPView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var agreCheck: Bool = false
    @State var errorText: String = ""
    @State private var showAlert = false
    @State private var shouldAnimate = false
    
    var alert: Alert{
        Alert(title: Text("verify you email"), message: Text("Check your email"), dismissButton: .default(Text("Dismiss"))
                {
                    self.emailAddress = ""
                    self.password = ""
                    self.errorText = ""
                    self.agreCheck = false
                    
                    
                    
                    
                }
        
        
        )
        
    }
    
    
    
    var body: some View {
        VStack{
            
            AppTitleView(Title: "Sign UP")
            VStack(spacing: 10)
            {
                Text("Email")
                    .font(.title)
                    .fontWeight(.light)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .leading)
                
                TextField("Enter email" ,text: $emailAddress)
                    .textContentType(.emailAddress)
                
                
                Text("Password")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .leading)
                
                
                SecureField("Enter password" , text: $password)
                
                Toggle(isOn: $agreCheck) {
                   Text("Please accept term condition")
                }
                
                .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .leading)
                
                
                
                
            
                
                Button(action: {
                    
                    if(self.agreCheck){
                        print("Printing outputs" + self.emailAddress, self.password  )
                        self.shouldAnimate = true
                        self.HellowHi(email:self.emailAddress, password:self.password)
                    }
                    else{
                         self.errorText = "Please Agree to the Terms and Condition"
                    }
                }) {
                    
                Text("Sign Up")
                    
                }
            
                Text(errorText).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            
                actINSignUp(SholudAnimate: self.$shouldAnimate)
            
                 Spacer()

                }.padding(10)

    }.edgesIgnoringSafeArea(.top).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).background(Color.white)
    
    
    .alert(isPresented: $showAlert, content: { self.alert })

}
    
    
    
    func HellowHi(email: String,password: String) {
        
        Auth.auth().signIn(withEmail: emailAddress, password: password){
            authResult,error in
            
            guard let user = authResult?.user,error == nil else {
                let errorText: String = error?.localizedDescription ?? "UNKOWUN ERROR"
                self.errorText = errorText
                
                return
            }
            
            
            Auth.auth().currentUser?.sendEmailVerification{
                (error) in
                if let error = error {
                    
                    self.errorText = error.localizedDescription
                    return
                    
                }
                
                self.showAlert.toggle()
                self.shouldAnimate = false
                
                
                
            }
            
            print("\(user.email!)")
        }
        
        
        
        
        
    }
    
    
    
    
}







struct SignUPView_Previews: PreviewProvider {
    static var previews: some View {
        SignUPView()
    }
}
