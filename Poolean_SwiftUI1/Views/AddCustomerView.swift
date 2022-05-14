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
    @State var days:[Int] = []
    
    var dayPicker:some View{
        VStack{
            
        }
    }
    
    
    var body: some View {
        
        ZStack{
            //#f2f1f6 Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            Color(0xf2f1f6).edgesIgnoringSafeArea(.all)
            
            VStack{
                RoundedRectangle(cornerRadius: 30)
                    .frame(width:100,height:5)
                    .foregroundColor(.black)
                    .padding(.top,7)
                    //.ignoresSafeArea(.all)
                
                HStack{
                    Text("Add Customer")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .padding()
                    Spacer()
                }
                    
                Spacer()
                //Text("Add Customer View -> \(customerModel.age)")
                HStack{
                    Text("Name:")
                        .padding(.leading)
                    Spacer()
                    RoundedTextField1(text_in: "Name", binding_string: $customerModel.name,background_color:.white)
                        .frame(maxWidth: 320)
                }
                .frame(maxWidth: 400)
                HStack{
                    Text("Age:").padding(.leading)
                    Spacer()
                    RoundedTextField1Generic(text_in: "Age", binding_string: $customerModel.age,background_color: .white)
                        .frame(maxWidth: 320)
                        
                }
                .frame(maxWidth: 400)
                
                HStack{
                    Text("Height: ").padding(.leading)
                    Spacer()
                    RoundedTextField1Generic(text_in: "height", binding_string: $customerModel.height,background_color: .white)
                        .frame(maxWidth: 320)
                        
                }
                .frame(maxWidth: 400)
                HStack{
                    Text("Weight:").padding(.leading)
                    Spacer()
                    RoundedTextField1Generic(text_in: "weight", binding_string: $customerModel.weight,background_color: .white)
                        .frame(maxWidth: 320)
                }
                .frame(maxWidth: 400)
                
                HStack{
                    Spacer()
                    Button(action: {
                        customerModel.id = UUID().uuidString // generate an id while saving.
                        // userViewModel.saveNewCustomer(customerModel)
                        //userViewModel.userModel.customers.append(customerModel)
                        userViewModel.addCustomerToInstitution(name: customerModel.name, age: customerModel.age, weight: customerModel.weight, height: customerModel.height, daysActive: [], monthsPayed: [])
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .font(.title)
                            .padding()
                            .padding(.trailing,30)
                    })
                    
                }

                
                Spacer()
                
                
                
                
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
