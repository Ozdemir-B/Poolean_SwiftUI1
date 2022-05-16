//
//  ShowAllUsersView.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 14.05.2022.
//

import SwiftUI


struct UserView:View{
    
    @StateObject var userViewModel:UserViewModel
    @State var user:UserModel
    @State var showDetails:Bool = false
    @State var editButtonPressed = false
    
    var body: some View{
        ZStack{
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Text(user.name)
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .padding()
                    Spacer()

                    
                    Button(action: {showDetails.toggle()}, label: {
                        Text("Details")
                            .padding()
                    })

                    }
                
                if showDetails{
                    VStack{
                        
                        HStack{
                            Spacer()
                            
                            Button(action: {editButtonPressed.toggle()}, label: {
                                ZStack{
                                    if editButtonPressed{
                                        Color.red.edgesIgnoringSafeArea(.all)
                                    }
                                    else {
                                        Color.blue.edgesIgnoringSafeArea(.all)
                                    }
                                    Text("Edit")
                                        .foregroundColor(.white)
                                }
                                .cornerRadius(5)
                                .frame(maxWidth:50)
                                .padding()
                            })
                        }
                        
                        if editButtonPressed{
                            
                            RoundedTextField1(text_in: user.name, binding_string: $user.name)
                                .padding()
                            
                            RoundedTextField1(text_in: user.password, binding_string: $user.password)
                                .padding()
                            
                            RoundedTextField1(text_in: user.email, binding_string: $user.email)
                                .padding()
                            
                            Button(action: {
                                if user.type == 1{
                                    user.type = 0
                                }
                                else{
                                    user.type = 1
                                }
                            }, label: {
                                if user.type == 0 { // Admin
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width:200,height:50)
                                        
                                        Text("Admin")
                                            .font(.system(size: 25, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                    }
                                    
                                }
                                else{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width:200,height:50)
                                            .foregroundColor(.white)
                                            .drawBorder(color: .black)
                                        
                                        Text("Regular")
                                            .font(.system(size: 25, weight: .bold, design: .rounded))
                                            .foregroundColor(.black)
                                    }
                                }
                            })
                            .padding()
                            
                            HStack{
                                Spacer()
                                
                                Button(action: {
                                    userViewModel.updateLocalUsersList(new: user)
                                    userViewModel.updateUserInfo(new: user)
                                    editButtonPressed = false
                                    
                                }, label: {
                                    Text("Save")
                                        .bold()
                                        .font(.title)
                                })
                                .padding()
                                .padding(.trailing)
                            }
                            
                        }
                        else {
                            Text("Password: \(user.password)")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                                .padding()
                            
                            Text("email: \(user.email)")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                                
                            
                            Button(action: {}, label: {
                                if user.type == 0{
                                    Text("Role: Admin")
                                        .font(.title)
                                        .padding()
                                }
                                else {
                                    Text("Role: Regular")
                                        .font(.title)
                                        .padding()
                                }
                            })
                        }
                    }
                
                }

            }
        }
        .cornerRadius(25)
        .padding()
    }
}

struct ShowAllUsersView: View {
    
    @StateObject var userViewModel:UserViewModel
    @State var userList:[UserModel] = [UserModel(),UserModel(),UserModel()]
    @State var tempUserModel:UserModel = UserModel()
    @Environment(\.presentationMode) var presentationMode
    
    /*
     init(userViewModel:UserViewModel){
         self._userViewModel = StateObject(wrappedValue: userViewModel)
         
         //let _ = userViewModel.firestoreLogin2(institutionId: userViewModel.userModel.institutionId)
         //print(x)
         print("----------- ShowAllUsersView -------- init -----------")
         //self.userList = userViewModel.usersList
         //return
     }
     */
    
    var body: some View {
        ZStack{
            Color.blue.opacity(0.1).edgesIgnoringSafeArea(.all)
            VStack{
                
                RoundedRectangle(cornerRadius: 50)
                    .frame(width:100,height:3)
                    .padding(.top)
                
                HStack{
                    Text("All Users")
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                        .padding()
                    
                    Spacer()
                }
                ScrollView{
                    ForEach(userViewModel.usersList,id: \.id){
                        user in
                        
                        UserView(userViewModel: userViewModel, user: user)
                        
                    }
                    
                }
            }
        }
    }
}

struct ShowAllUsersView_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllUsersView(userViewModel: UserViewModel())
    }
}
