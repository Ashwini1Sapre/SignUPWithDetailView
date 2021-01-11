//
//  SignInView.swift
//  SignUPWithDetailView
//
//  Created by Knoxpo MacBook Pro on 11/01/21.
//

import SwiftUI
import Firebase

struct actIndSignIn: UIViewRepresentable {
    @Binding var shloudAnimate: Bool
    
    
     func makeUIView(context: Context) -> UIActivityIndicatorView{
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
        if self.shloudAnimate
        {
            uiView.startAnimating()
            
        }
        else
        {
            uiView.stopAnimating()
        }
    }

}

struct SignInView: View {
    @State private var shouldAnimate = false
    @Environment(\.presentationMode) var presentationMode
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var verifyEmail: Bool = true
    @State  private var ShowEmailAlert = false
    @State private var ShowPasswordAlert = false
    @State var signUpIsPresent: Bool = false
    @State var errortext: String = ""
    var onDismiss: () -> ()
    
    var VerifyEmailAlert: Alert{
        Alert(title: Text("Verify your mail id"), message: Text("Please Check eamil Id Link"), dismissButton: .default(Text("Dismiss")){
            self.presentationMode.wrappedValue.dismiss()
            self.emailAddress = ""
            self.verifyEmail = true
            self.password = ""
            self.errortext = ""
            
            
        }
        
        
        )
        
        
    }
    
    var VerifyPasswordAlert: Alert{
        Alert(title: Text("Vreify your password"), message: Text("Please check email id"), dismissButton: .default(Text("Dismiss"))
                {
                    self.emailAddress = ""
                    self.verifyEmail = true
                    self.password = ""
                    self.errortext = ""
                    
                    
                    
                    
                })
        
        
    }
    
    
    var body: some View {
        VStack{
            
            AppTitleView(Title: "Sign IN")
            VStack(spacing: 10){
                
                Text("Email")
                    .font(.title)
                    .fontWeight(.light)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .leading)
                TextField("user@domain.com", text: $emailAddress)
                    .textContentType(.emailAddress)
                
                Text("Passwod")
                    .font(.title)
                    .fontWeight(.light)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .leading)
                SecureField("Enter password", text: $password)
                
                
                
                
//
//                Button(action: {
//
//                    self.signUpIsPresent = true
//
//
//                })
//                {
//                    Text("Sign UP")
//
//                }.sheet(isPresented: self.$signUpIsPresent)
//                    {
//
//                    SignUPView()
//                }
                
                
                
                Button(action: {
                 //   self.shouldAnimate = true
                    
                  
                    
                    
                   self.sayHelloWorld(email:self.emailAddress,password:self.password)
                    
                   
                    
                    
                })
                {
                    Text("Sign IN")
                }
                .sheet(isPresented: self.$signUpIsPresent)
                    {
                    
                    ContentView()
               }
                
                Button(action: {
                    Auth.auth().sendPasswordReset(withEmail: self.emailAddress)
                        {
                        error in
                        if let error = error {
                            self.errortext = error.localizedDescription
                            
                            print("\(self.errortext)")
                            return
                            
                            
                        }
                        self.ShowPasswordAlert.toggle()
                        
                    }
                    
                    
                })
                {
                    Text("Forgot password")
                }
                
                
                Text(errortext)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .leading)
                actIndSignIn(shloudAnimate: self.$shouldAnimate)
                if (!verifyEmail) {

                    Button(action: {

                        Auth.auth().currentUser?.sendEmailVerification { (error) in
                            if let error = error {
                            self.errortext = error.localizedDescription
                            return
                            }
                        self.ShowEmailAlert.toggle()

                        }
                    }) {

                    Text("Send Verify Email Again")
                        
                        
                       
                    }
                    
                    

                }


            }.padding(10)



        }.edgesIgnoringSafeArea(.top).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).background(Color.white)

        .alert(isPresented: $ShowEmailAlert, content: { self.VerifyEmailAlert })

        .alert(isPresented: $ShowPasswordAlert, content: { self.VerifyPasswordAlert })

}
    func sayHelloWorld(email: String, password: String) {

        
               
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            
            self.signUpIsPresent = true
           

        if let error = error
            {
            self.errortext = error.localizedDescription
                self.shouldAnimate = false

            return
            }


        guard user != nil else {
          
            return }


        self.verifyEmail = user?.user.isEmailVerified ?? false


        if(!self.verifyEmail)
            {
            self.errortext = "Please verify your email"
            self.shouldAnimate = false
            return
            }

            self.emailAddress = ""
            self.verifyEmail = true
            self.password = ""
            self.errortext = ""
            self.onDismiss()
            self.presentationMode.wrappedValue.dismiss()
            self.shouldAnimate = false

        }

        
        
        
        }

    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(onDismiss: {print("hi")})
    }
}
