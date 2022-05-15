//
//  SettingsView.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 9.04.2022.
//

import SwiftUI



struct SettingsView: View {
    
    @StateObject var userViewModel:UserViewModel
    @State var isAdmin:Int = 0 // 0:Admin, 1:Regular
    @State var newUserSheetBool:Bool = false
    @State var showAllUsersSheetBool:Bool = false
    @State var changePasswordSheetBool:Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var adminSettings:some View{
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            VStack{
                
                HStack{
                    Text("Settings")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .padding()
                        .padding(.bottom,20)
                    Spacer()
                }
                
                Spacer()
                ScrollView{
                    if userViewModel.userModel.type == 0 {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                //.frame(width: 300, height: 300)
                                //.frame(minHeight:300)
                                .foregroundColor(Color(0xf2f1f6))
                            
                            
                            
                            VStack{
                                HStack{
                                    Text("User Settings").font(.title3)
                                        .padding([.leading,.top])
                                    Spacer()
                                }
        
                                
                                Button(action: {
                                    newUserSheetBool.toggle()
                                }, label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(maxHeight: 100)
                                        
                                        Text("New User")
                                            .font(.system(size: 40, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                    }
                                })
                                .padding()
                                //.padding(.top)
                                .sheet(isPresented: $newUserSheetBool) {
                                    //LoginView(userViewModel: userViewModel)
                                    AddNewUserView(userViewModel: userViewModel)
                                    }
                                
                                
                                Button(action: {
                                    showAllUsersSheetBool.toggle()
                                }, label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(maxHeight: 100)
                                        
                                        Text("Show Users")
                                            .font(.system(size: 40, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                    }
                                })
                                .padding()
                                .sheet(isPresented: $showAllUsersSheetBool) {
                                    //LoginView(userViewModel: userViewModel)
                                    ShowAllUsersView(userViewModel: userViewModel)
                                    }
                                
                                Spacer()
                            }
                        }
                        .padding()
                    }
                    
                    
                    // -----------------------------
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            //.frame(width: 300, height: 300)
                            //.frame(minHeight:300)
                            .foregroundColor(Color(0xf2f1f6))
                        
                        
                        
                        VStack{
                            HStack{
                                Text("Account Settings").font(.title3)
                                    .padding([.leading,.top])
                                Spacer()
                            }
    
                            
                            if userViewModel.userModel.type == 0 {
                                Button(action: {
                                    newUserSheetBool.toggle()
                                }, label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(maxHeight: 100)
                                        
                                        Text("Change Password")
                                            .font(.system(size: 40, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                    }
                                })
                                .padding()
                                //.padding(.top)
                                .sheet(isPresented: $newUserSheetBool) {
                                    //LoginView(userViewModel: userViewModel)
                                    AddNewUserView(userViewModel: userViewModel)
                                    }
                            }
                            
                            
                            Button(action: {
                                showAllUsersSheetBool.toggle()
                            }, label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(maxHeight: 100)
                                    
                                    Text("Account")
                                        .font(.system(size: 40, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                }
                            })
                            .padding()
                            .sheet(isPresented: $showAllUsersSheetBool) {
                                //LoginView(userViewModel: userViewModel)
                                ShowAllUsersView(userViewModel: userViewModel)
                                }
                            
                            Spacer()
                        }
                    }
                    .padding()
                    
                }
                
                
            }

        }
    }
    
    
    var body: some View {
        
        if userViewModel.userModel.type == 0 {
            adminSettings
        }
        else{
            adminSettings
        }
        
    }
}

struct SettingsAdminView: View {
    
    @StateObject var userViewModel:UserViewModel
    
    var body: some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
                Text("Admin Settings ")
                Spacer()
            }
            Spacer()
        }
        .background(.green)
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(userViewModel: UserViewModel())
        //SettingsAdminView(userViewModel: UserViewModel())
    }
}
