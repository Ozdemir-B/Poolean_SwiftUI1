//
//  AddNewUserView.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 14.05.2022.
//

import SwiftUI

struct AddNewUserView: View {
    
    @StateObject var userViewModel:UserViewModel
    
    @State var tempUserModel:UserModel = UserModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            //Color.blue
            
            VStack{
                HStack{
                    Text("Add New User")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .padding()
                    Spacer()
                }
                
                Spacer()
                
                HStack{
                    Spacer()
                    Button(action: {
                        userViewModel.addRegularUser(name: tempUserModel.name, institutionId: userViewModel.userModel.institutionId, password: tempUserModel.password, email: tempUserModel.email, type: tempUserModel.type)
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth:150,maxHeight: 50)
                            
                            Text("Save")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    })
                }
                //.padding([.top,.trailing],30)
                .padding()
                
                
                
                
                RoundedTextField1(text_in: "name", binding_string: $tempUserModel.name,background_color: .white)
                    .drawBorder(color: .black)
                    .padding(.horizontal)
                
                RoundedTextField1(text_in: "password", binding_string: $tempUserModel.password,background_color: .white)
                    .drawBorder(color: .black)
                    .padding()
                RoundedTextField1(text_in: "email", binding_string: $tempUserModel.email,background_color: .white)
                    .drawBorder(color: .black)
                    .padding(.horizontal)

                Button(action: {
                    if tempUserModel.type == 1{
                        tempUserModel.type = 0
                    }
                    else{
                        tempUserModel.type = 1
                    }
                }, label: {
                    if tempUserModel.type == 0 { // Admin
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
                            
                            Text("Admin")
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                                .foregroundColor(.black)
                        }
                    }
                })
                .padding()
                
                Spacer()
            }
            
        }
    }
}

struct AddNewUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewUserView(userViewModel: UserViewModel())
    }
}
