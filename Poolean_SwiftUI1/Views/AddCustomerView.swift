//
//  AddCustomerView.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 19.04.2022.
//

import SwiftUI

struct AddCustomerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var userViewModel:UserViewModel
    @State var customerModel = CustomerModel()
    
    
    var body: some View {
        
        ZStack{
            //#f2f1f6 Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            Color(0xf2f1f6).edgesIgnoringSafeArea(.all)
            VStack{
                Text("Add Customer View -> \(customerModel.age)")
                RoundedTextField1(text_in: "Name", binding_string: $customerModel.name,background_color:.white)
                RoundedTextField1Generic(text_in: "Age", binding_string: $customerModel.age,background_color: .white)
                RoundedTextField1Generic(text_in: "weight", binding_string: $customerModel.weight,background_color: .white)
                RoundedTextField1Generic(text_in: "height", binding_string: $customerModel.height,background_color: .white)
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action:{
                    customerModel.id = UUID().uuidString // generate an id while saving.
                    // userViewModel.saveNewCustomer(customerModel)
                    //userViewModel.userModel.customers.append(customerModel)
                    userViewModel.addCustomerToInstitution(name: customerModel.name, age: customerModel.age, weight: customerModel.weight, height: customerModel.height, daysActive: [], monthsPayed: [])
                    presentationMode.wrappedValue.dismiss()
                },label: {
                    Text("Save")
                })
            })
        }
    }
        
        
}
    //.onDisappear(perform: {print("ADD customer view closed.")} )

struct AddCustomerView_Previews: PreviewProvider {
    static var previews: some View {
        AddCustomerView(userViewModel:UserViewModel())
    }
}
