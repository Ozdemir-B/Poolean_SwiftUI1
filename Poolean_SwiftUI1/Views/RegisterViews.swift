//
//  RegisterViews.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 29.03.2022.
//

import Foundation
import SwiftUI


struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    
    //@State var institutionId:Binding<String>
    
    @State var selected:Int = 0
    @State var picker_selection:String = ""
    @State var reset_password_text:String = "Reset Password"
    @State var institution_id = ""
    @State var password = ""
    @State var alertShow:Bool = false
    @State var messageText:String = ""
    
    @StateObject var userViewModel:UserViewModel
    
    func controlLogin(){
        if true{//userViewModel.isFirestoreLoginDone{//userViewModel.isFirestoreLoginDone{
            if userViewModel.isUserFilled{
                print("yes yes yes yes yes yes yes yes yes")
                presentationMode.wrappedValue.dismiss()
            }
            else {
                print("inside else :: ")
                //print("register view result :: \(result)")
                print("userViewModel.isUserFilled :: \(userViewModel.isUserFilled)")
                print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
                alertShow = true
            }
        }
    }
    

    var body: some View {
        VStack{
            
            HStack{
                Text("Login")
                    .font(.system(size:40))
                    .foregroundColor(.white)
                    .padding([.leading,.top],35)
                    Spacer()
                
            }
            .frame(maxWidth:.infinity)
            .padding(.bottom)
            
            /*
             Picker(selection: $selected, label: Text(""), content: {
                             Text("Admin").tag(0)
                             Text("Worker").tag(1)
             }).pickerStyle(.segmented)
                 .padding()
                 .padding(.horizontal,25)
             */
                

            
            Spacer()
            
            HStack{
                if messageText == "Logged In"{
                    Text(messageText)
                        .font(.system(size: 30))
                        .foregroundColor(.green)
                }
                else if messageText == "Try Again!!"{
                    Text(messageText)
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                }
                else {
                    Text(messageText)
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                }
                    
            }
            
            Spacer()
            
            RoundedTextField1(text_in: "institutionId", binding_string: $institution_id)
            
            SecureFieldWithButton(text:"password",binding_value: $password){
                
                messageText = "Loading..."
                
                if true {

                    
                    let result = userViewModel.firestoreLogin(institutionId: institution_id, password: password)
                    //let result = userViewModel.firestoreLogin(institutionId: institution_id, password: password)
                    //print("register view result :: \(result)")
                    print("userViewModel.isUserFilled :: \(userViewModel.isUserFilled)")
                    
                    print("before sleep(2)")
                    //sleep(2)
                    print("after sleep(2)")
                    
                    //print("register view result :: \(result)")
                    print("userViewModel.isUserFilled :: \(userViewModel.isUserFilled)")
                    
                    if true{//userViewModel.isFirestoreLoginDone{//userViewModel.isFirestoreLoginDone{
                        if userViewModel.loginFetchState == 1{//userViewModel.isUserFilled{
                            messageText = "Logged In"
                            print("yes yes yes yes yes yes yes yes yes")
                            presentationMode.wrappedValue.dismiss()
                        }
                        else if userViewModel.loginFetchState == -1 {
                            messageText = "Try Again!!"
                            print("inside else :: ")
                            //print("register view result :: \(result)")
                            print("userViewModel.isUserFilled :: \(userViewModel.isUserFilled)")
                            print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
                            //alertShow = true
                        }
                    }
                    
                    
                    //alertShow = true
                }
                
                //reset_password_text = "adsadsadsdad"
            }
            .padding([.horizontal])

           Button(action: {
               //let _ = print("Reset password button pressed")
               //print("username : \(username)")
               //print("password : \(password)")
               if selected == 0{ // only admin can change password
                   //change password
                   presentationMode.wrappedValue.dismiss()
                   
                   
               }
               if selected == 1{
                   //reset_password_text = "asdasd"
               }
               
               
           }, label: {
               ZStack{
                   /*RoundedRectangle(cornerRadius: 20.0)
                       .foregroundColor(.red.opacity(0.7))*/
                   Text(reset_password_text)
                       .foregroundColor(.white)
                       
               }

           })
               .foregroundColor(.white)
               .frame(maxWidth:220,maxHeight: 60)
           
            Spacer()
  
       }
       .frame(maxWidth: .infinity, maxHeight: .infinity)
       .background(.black.opacity(0.9))
       .alert("Wrong! Try again.", isPresented: $alertShow, actions: {
           Button(action: {alertShow = false}, label: {Text("OK")})
       })
       //.padding()
   }
}


struct SigninView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var username:String = ""
    @State var password:String = ""
    @State var selected:Int = 0
    @State var email:String = ""
    @State var name:String = ""
    @StateObject var userViewModel:UserViewModel
    
    var body: some View {
        
        
        VStack{
            
            HStack{
                Text("Signin")
                    .font(.system(size:40))
                    .foregroundColor(.white)
                    .padding()
                    Spacer()
            }
            .frame(maxWidth:.infinity)
            .padding(.bottom)
            Text(name)
            
            Picker(selection: $selected, label: Text(""), content: {
                            Text("Basic").tag(0)
                            Text("Premium").tag(1)
                            Text("Pro").tag(2)
                        }).pickerStyle(SegmentedPickerStyle())
                .padding()
            
            Spacer()
            
            RoundedTextField1(text_in: "Name, Surname", binding_string: $name)
            
            RoundedTextField1(text_in: "Institution Name", binding_string: $username)
            
            TextField("e-mail", text:$email)
                .foregroundColor(.black)
                .padding()
                .background(.gray)
                .cornerRadius(25.0)
                .padding(.horizontal)
            
            SecureFieldWithButton(text: "password", binding_value: $password, action: {
                //presentationMode.wrappedValue.dismiss()
                userViewModel.addNewInstitution(name: name, institutionId: username, password: password, type: 0, email: email)
                
            })
                .padding([.leading,.trailing])
            
            
                
           //Spacer()

           
            Spacer()
           /*Image(systemName: "xmark.circle")
               .foregroundColor(.white)
               .padding()*/
               
       }
       .frame(maxWidth: .infinity, maxHeight: .infinity)
       .background(.black.opacity(0.9))
       //.padding()
   }
}

struct RegisterViews_Previews: PreviewProvider {
    //@State var ud = UserModel()
    static var previews: some View {
        
        LoginView(userViewModel:UserViewModel())
        SigninView(userViewModel:UserViewModel())
        
    }
}
