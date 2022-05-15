//
//  ShowAllUsersView.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 14.05.2022.
//

import SwiftUI

struct ShowAllUsersView: View {
    
    @StateObject var userViewModel:UserViewModel
    @State var userList:[UserModel] = [UserModel(),UserModel(),UserModel()]
    @State var tempUserModel:UserModel = UserModel()
    @Environment(\.presentationMode) var presentationMode
    
    init(userViewModel:UserViewModel){
        self._userViewModel = StateObject(wrappedValue: userViewModel)
        
        //let x = userViewModel.fetchUsersOfInstitution()
        //print(x)
        print("----------- ShowAllUsersView -------- init -----------")
        //self.userList = userViewModel.usersList
        return
    }
    
    var body: some View {
        ZStack{
            Color.blue.opacity(0.1).edgesIgnoringSafeArea(.all)
            VStack{
                ForEach(userList,id: \.id){
                    user in
                    Text(user.name)
                    
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
