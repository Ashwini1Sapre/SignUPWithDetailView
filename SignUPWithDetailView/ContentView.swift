//
//  ContentView.swift
//  SignUPWithDetailView
//
//  Created by Knoxpo MacBook Pro on 11/01/21.
//

import SwiftUI
import Firebase
struct ContentView: View {
    @State var name: String = ""
    @State var position: String = ""
    @State private var showAlert = false
    @State var SignInRequest: Bool = false
    var docRef : DocumentReference!
    var docList : ListenerRegistration!
    var docref1 = Firestore.firestore().document("user/position")
    
    
    var alert: Alert{
        Alert(title: Text("Data save in cloude successfully"), message: Text(""), dismissButton: .default(Text("Dismiss"))
                {
                    self.name = ""
                    self.position = ""
                   
                    
                    
                    
                    
                }
        
        
        )
        
    }
    
    
    var body: some View {
        

        VStack{
            
            TextField("EnterName",text: $name )
            
            TextField("Enter position", text: $position)
            
            
            
            Button(action: {
              
                self.SignInRequest = true
                let datatoSave : [String: Any] = ["name": name, "position": position]
               
                docref1.setData(datatoSave) { (error) in
                    if let error = error {
                        print("\(error.localizedDescription)")
                        
                    }
                    else{
                        
                        
                        print("data save")
                        
                      //  Alert(title:Text("Data save successfully"), message:Text("") , dismissButton: .default(Text("Dismiss")))
                            
                           
                    }
                   
                    
                }
                }
                
            )
           
            {
                
                Text("Save")
                
                   
                
                
            }
            .alert(isPresented: $showAlert, content: {
                self.alert
            })
            
            
            .sheet(isPresented: $SignInRequest) {
                WelcomeView()
                
            }
            
            
        }
        
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
