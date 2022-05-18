//
//  SettingsView.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 9.04.2022.
//

import SwiftUI

struct PersonalInfoView:View{
    
    @StateObject var userViewModel:UserViewModel
    @State var user:UserModel //= userViewModel.userModel
    @State var showDetails:Bool = false
    @State var editButtonPressed = false

    init(userViewModel:UserViewModel){
        self._userViewModel = StateObject(wrappedValue: userViewModel)
        self.user = userViewModel.userModel
    }
    
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
                                    userViewModel.updatePersonalInfo(new: user)
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
        .cornerRadius(10)
        .padding()
    }
}


struct SettingsView: View {
    
    @StateObject var userViewModel:UserViewModel
    @State var isAdmin:Int = 0 // 0:Admin, 1:Regular
    @State var newUserSheetBool:Bool = false
    @State var showAllUsersSheetBool:Bool = false
    @State var changePasswordSheetBool:Bool = false
    @State var aboutButtonPressed = false
    
    
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
                                    showAllUsersSheetBool = true // .toggle() makes it false and true again and again
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
                                    //let _ = userViewModel.fetchUsersOfInstitution()
                                    // calling above function in ShowAllUsersView or here makes an infinite loop. I don't know why ????? -> search it.
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
                                /*
                                 Button(action: {
                                     newUserSheetBool.toggle()
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
                                 //.padding(.top)
                                 .sheet(isPresented: $newUserSheetBool) {
                                     //LoginView(userViewModel: userViewModel)
                                     AddNewUserView(userViewModel: userViewModel)
                                     }
                                 */
                                PersonalInfoView(userViewModel: userViewModel)
                            }
                            
                            
                            Button(action: {
                                aboutButtonPressed.toggle()
                            }, label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(maxHeight: 100)
                                    
                                    Text("About")
                                        .font(.system(size: 40, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                }
                            })
                            .padding()
                            .sheet(isPresented: $aboutButtonPressed) {
                                //LoginView(userViewModel: userViewModel)
                                ZStack{
                                    Color.blue.opacity(0.5).edgesIgnoringSafeArea(.all)
                                    VStack(alignment:.center){
                                        Spacer()
                                        Text("Kocaeli University 2022")
                                            .foregroundColor(.white)
                                            .font(.title)
                                            .padding()
                                        Text("Berkay Özdemir - Alper Ayhan")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                        
                                        Spacer()
                                        Text("Verison 1.0")
                                            .foregroundColor(.white)
                                            .font(.title3)
                                            .padding()
                                        
                                    }
                                }
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
