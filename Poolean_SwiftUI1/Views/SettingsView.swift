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
    
    var body: some View {
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
                    ZStack(alignment: .center){
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 300, height: 300)
                            .padding()
                            .foregroundColor(Color(0xf2f1f6))
                    }
                }
                
                
            }

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
        SettingsAdminView(userViewModel: UserViewModel())
    }
}
