//
//  ContentView.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 25.03.2022.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        

        //(userViewModel.isUserFilled ? MainScreenView(userViewModel: userViewModel) : NoInfoView(userViewModel: userViewModel)) // No go...

        if !userViewModel.isUserFilled {
            NoInfoView(userViewModel: userViewModel)
        } else {
            MainScreenView(userViewModel: userViewModel)
        }
        

    }
}

struct NoInfoView: View {
    
    @StateObject var userViewModel:UserViewModel
    
    var body: some View {
        ZStack{
            CustomBackgroundImage(image:"pool_1")
            VStack{
                HStack{
                    VStack(alignment:.leading){
                        Text("Welcome to")
                            .font(.system(size:60))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            
                        Text("Poolean")
                            .font(.system(size:60))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            //.padding([.leading, .bottom, .trailing])
                    }
                    .padding(.leading,20)
        
                    Spacer()
                }
                
                .frame(maxWidth:.infinity)
                .padding(.top,50)

                Spacer()
                
                Button2(label:"Login",action:{
                    userViewModel.showLoginPage = true
                    //let _ = print("------")
                    
                })
                    //.padding(.bottom,10)
                    .padding([.trailing,.leading],50)
                    .sheet(isPresented: $userViewModel.showLoginPage) {
                        LoginView(userViewModel: userViewModel)
                        }
                    .foregroundColor(.gray.opacity(0.85))
                
                Text(userViewModel.userModel.institutionId ?? "")
                
                Button(action:{
                    userViewModel.showSigninPage = true
                },label:{Text("Signin")
                        .foregroundColor(.black)
                })
                    .padding(.bottom,50)
                    .padding([.trailing,.leading],50)
                    .sheet(isPresented: $userViewModel.showSigninPage) {
                        SigninView(userViewModel: userViewModel)
                            //.background(.black)
                        }
                    .foregroundColor(.gray.opacity(0.85))
                
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        MainScreenView(userViewModel: UserViewModel())
    }
}

