//
//  DetailedCustomerView.swift
//  
//
//  Created by Berkay Özdemir on 18.04.2022.
//

import SwiftUI

struct DetailedCustomerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var selection:Int = 0
    @StateObject var userViewModel:UserViewModel
    @Binding var customerModel:CustomerModel
    @State var tempModel:CustomerModel = CustomerModel()
    //@State var date = Date()
    @State var showAlert1:Bool = false
    @State var price:Double = 0
    @State var dateString:String = "01-2022"
    @State var editPriceBool:Bool = false
    @State var addPaymentBool:Bool = false
    @State var priceTemp:Double = 0
    
    init(userViewModel:UserViewModel,customerModel:Binding<CustomerModel>){
        self._userViewModel = StateObject(wrappedValue: userViewModel)
        self._customerModel = customerModel
        self._tempModel = State(wrappedValue:$customerModel.wrappedValue)
        print("init method ::: payed months=\(self.tempModel.monthsPayed)")
        self.searchForPrice()
          
    }
    
    
    //func removeFromArray<T>(array:[T],item:T){}
    
    func removeDay(dayNumber:Int){
        var index:Int = 0
        for d in self.tempModel.daysActive{
            if d == dayNumber{
                self.tempModel.daysActive.remove(at: index)
            }
            
            index+=1
        }
    }
    
    func searchForPrice()->Int{ // if dateString exists, then return the index of the string, else return -1
        //also updates the price value everytime runes. If the date exists, fills the price ; else price=0
        
        print("searchForPrice tempModel months list:: \(self.tempModel.monthsPayed)")
        
        var returnVal:Int = -1
        let dateString:String = "\(String(monthIndex))-\(String(year))"
        var tempPrice:String = ""
        var indexx:Int = 0
        for dd in tempModel.monthsPayed{
            if dd.contains(dateString){
                print("inside searchForPrice -> -> \(dd)")
                let dateSplit = dd.components(separatedBy: "-")
                tempPrice=dateSplit[2] as! String ?? "-1"
                print("this date \(dateString) is filled")
                self.price = Double(tempPrice)!
                
                returnVal = indexx
                indexx+=1
                return indexx
            }
            else{
                //print("this date \(dateString) is empty")
                //self.price = 0
            }
        }
        self.price = 0
        return returnVal
    }
    
    func priceToString(){
        
    }
     
    @State var year = 2022
    @State var months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    @State var monthIndex = 0
    var historyView: some View{
        return VStack{
            
            HStack(){
                Spacer()
                Button(action: {
                    editButtonPressed.toggle()
                    if editButtonPressed{
                        editButtonColor = .blue
                    }
                    else{
                        editButtonColor = .gray
                    }
                }, label: {
                    ZStack{
                        editButtonColor.edgesIgnoringSafeArea(.all).cornerRadius(10)
                        
                        Text("Edit")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                })
                .frame(width:80,height:40)
            }
            .padding(.horizontal)
            
            ZStack{
                Color.blue.edgesIgnoringSafeArea(.all)
                HStack{
                    Image(systemName: "chevron.left").foregroundColor(.white).font(.title).padding()
                        .onTapGesture {
                            year-=1
                            self.searchForPrice()
                        }
                    Spacer()
                    Text(String(year)).foregroundColor(.white).font(.title)
                    Spacer()
                    Image(systemName:"chevron.right").foregroundColor(.white).font(.title).padding()
                        .onTapGesture {
                            year+=1
                            self.searchForPrice()
                        }
                }
            }
            .cornerRadius(20)
            .padding(.horizontal)
            //.padding()
            
            ZStack{
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 150)
                    .foregroundColor(.blue.opacity(0.3))
                    .padding()
                VStack{
                    Spacer()
                    HStack{
                        Image(systemName: "chevron.left").foregroundColor(.white).font(.title).padding()
                            .onTapGesture {
                                if monthIndex == 0 {
                                    monthIndex = 11
                                    year-=1
                                }
                                else {
                                    monthIndex -= 1
                                }
                                self.searchForPrice()
                            }
                        Spacer()
                        Text(months[monthIndex]).foregroundColor(.white).font(.title)
                        Spacer()
                        Image(systemName:"chevron.right").foregroundColor(.white).font(.title).padding()
                            .onTapGesture {
                                if monthIndex == 11 {
                                    monthIndex = 0
                                    year+=1
                                }
                                else {
                                    monthIndex += 1
                                }
                                self.searchForPrice()
                            }
                    }
                    .padding(.horizontal)
                    Spacer()
                }
            }
            
            if editPriceBool{
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 80)
                        .foregroundColor(.gray.opacity(0.7))
                        .padding()
                        .onTapGesture {
                            editPriceBool = false
                        }
                    HStack{
                        Text("Price:")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.leading)
                        VStack{
                            //RoundedTextField1Generic(text_in: "price", binding_string: $price, background_color: .white)
                            TextField("price", value:$priceTemp,formatter: NumberFormatter())
                                .foregroundColor(.white)
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                .padding(.horizontal)
                            
                            RoundedRectangle(cornerRadius: 1)
                                .foregroundColor(.white)
                                .frame(height:1)
                                .padding(.horizontal)
                                
                            
                        }
                        
                        Button(action: {
                            //updateFunction
                            self.price = self.priceTemp
                            let paymentString:String = "\(String(monthIndex))-\(String(year))-\(String(price))"
                            
                            let indx = self.searchForPrice()
                            print(self.price)
                            
                            if indx != -1 {
                                print("this date is filled")
                                self.tempModel.monthsPayed[indx] = paymentString
                            }
                            else {
                                print("this date is empty")
                                self.tempModel.monthsPayed.append(paymentString)
                                
                                
                            }
                            
                            
                            editPriceBool.toggle()
                            
                            
                        }, label: {
                            Image(systemName: "chevron.right")
                                .padding(.trailing)
                                .font(.title)
                                .foregroundColor(.white)
                        })
                    }
                    .padding()
                }
                
            }
            else{
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 80)
                        .foregroundColor(.gray.opacity(0.3))
                        .padding()
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Text("\(months[monthIndex])/\(String(year))-\(price)₺").foregroundColor(.white).font(.title)
                            Spacer()

                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                }
                .onAppear(perform: {
                    self.searchForPrice()
                })
                .onTapGesture {
                    editPriceBool = true
                }
            }
            
            
            Spacer()
        }
    }
    
    @State var editButtonPressed:Bool = false
    @State var editButtonColor:Color = .gray
    var showInfoView:some View{
        VStack{
            ZStack{
                Color.blue.opacity(0.3).edgesIgnoringSafeArea(.all)
                VStack{
                    HStack(){
                        Spacer()
                        Button(action: {
                            editButtonPressed.toggle()
                            if editButtonPressed{
                                editButtonColor = .blue
                            }
                            else{
                                editButtonColor = .gray
                            }
                        }, label: {
                            ZStack{
                                editButtonColor.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                
                                Text("Edit")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        })
                        .frame(width:80,height:40)
                    }
                    .padding(.horizontal)
                    
                    if !editButtonPressed{
                        Text("Name: \(customerModel.name)")
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                        Text("Age: \(customerModel.age)")
                            .font(.title)
                            .foregroundColor(.white)
                        Text("Height: \(customerModel.height)")
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                        Text("Weight: \(customerModel.weight)")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    else{
                        RoundedTextField1(text_in: "Name", binding_string: $tempModel.name, background_color: .white)
                        RoundedTextField1Generic(text_in: "Age", binding_string: $tempModel.age, background_color: .white)
                        RoundedTextField1Generic(text_in: "Height", binding_string: $tempModel.height, background_color: .white)
                        RoundedTextField1Generic(text_in: "Weight", binding_string: $tempModel.weight, background_color: .white)
                    }

                    //RoundedTextField1(text_in: <#T##String#>, binding_string: <#T##Binding<String>#>, background_color: <#T##Color#>)
                }
                .padding()
            }
            .cornerRadius(25)
            .padding()
            
            ZStack{
                Color.blue.opacity(0.3).edgesIgnoringSafeArea(.all)//ignoresSafeArea(.all)
                
                VStack{
                    HStack(){
                        Button(action: { // 1
                            if editButtonPressed{
                                if tempModel.daysActive.contains(1){
                                    removeDay(dayNumber: 1)
                                }
                                else{
                                    tempModel.daysActive.append(1)
                                }
                                print(tempModel.daysActive)
                            }
                        }, label: {
                            
                            if tempModel.daysActive.contains(1){
                                ZStack{
                                    editButtonColor.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Pazartesi")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            }
                            else {
                                ZStack{
                                    Color.white.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Pazartesi")
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                .drawBorder(color: .black)
                            }
                        })
                        .frame(minWidth:120,maxWidth: 150) //width:80,height:40)
                        .frame(height:40)
                        .padding()
                        
                        Spacer()
                        Button(action: { // 2
                            if editButtonPressed{
                                if tempModel.daysActive.contains(2){
                                    removeDay(dayNumber: 2)
                                }
                                else{
                                    tempModel.daysActive.append(2)
                                }
                                print(tempModel.daysActive)
                            }
                        }, label: {
                            
                            if tempModel.daysActive.contains(2){
                                ZStack{
                                    editButtonColor.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Salı")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            }
                            else {
                                ZStack{
                                    Color.white.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Salı")
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                .drawBorder(color: .black)
                            }
                        })
                        .frame(minWidth:120,maxWidth: 150) //width:80,height:40)
                        .frame(height:40)
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    HStack(){
                        Button(action: { // 3
                            if editButtonPressed{
                                if tempModel.daysActive.contains(3){
                                    removeDay(dayNumber: 3)
                                }
                                else{
                                    tempModel.daysActive.append(3)
                                }
                                print(tempModel.daysActive)
                            }
                        }, label: {
                            
                            if tempModel.daysActive.contains(3){
                                ZStack{
                                    editButtonColor.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Çarşamba")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            }
                            else {
                                ZStack{
                                    Color.white.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Çarşamba")
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                .drawBorder(color: .black)
                            }
                        })
                        .frame(minWidth:120,maxWidth: 150) //width:80,height:40)
                        .frame(height:40)
                        .padding()
                        
                        Spacer()
                        Button(action: { // 4
                            if editButtonPressed{
                                if tempModel.daysActive.contains(4){
                                    removeDay(dayNumber: 4)
                                }
                                else{
                                    tempModel.daysActive.append(4)
                                }
                                print(tempModel.daysActive)
                            }
                        }, label: {
                            
                            if tempModel.daysActive.contains(4){
                                ZStack{
                                    editButtonColor.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Perşembe")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            }
                            else {
                                ZStack{
                                    Color.white.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Perşembe")
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                .drawBorder(color: .black)
                            }
                        })
                        .frame(minWidth:120,maxWidth: 150) //width:80,height:40)
                        .frame(height:40)
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    HStack(){
                        Button(action: { // 5
                            if editButtonPressed{
                                if tempModel.daysActive.contains(5){
                                    removeDay(dayNumber: 5)
                                }
                                else{
                                    tempModel.daysActive.append(5)
                                }
                                print(tempModel.daysActive)
                            }
                        }, label: {
                            
                            if tempModel.daysActive.contains(5){
                                ZStack{
                                    editButtonColor.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Cuma")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            }
                            else {
                                ZStack{
                                    Color.white.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Cuma")
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                .drawBorder(color: .black)
                            }
                        })
                        .frame(minWidth:120,maxWidth: 150) //width:80,height:40)
                        .frame(height:40)
                        .padding()
                        
                        Spacer()
                        Button(action: { // 6
                            if editButtonPressed{
                                if tempModel.daysActive.contains(6){
                                    removeDay(dayNumber: 6)
                                }
                                else{
                                    tempModel.daysActive.append(6)
                                }
                                print(tempModel.daysActive)
                            }
                            
                        }, label: {
                            
                            if tempModel.daysActive.contains(6){
                                ZStack{
                                    editButtonColor.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Cumartesi")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            }
                            else {
                                ZStack{
                                    Color.white.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Cumartesi")
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                .drawBorder(color: .black)
                            }
                        })
                        .frame(minWidth:120,maxWidth: 150) //width:80,height:40)
                        .frame(height:40)
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    HStack(){
                        Button(action: { // 7
                            if editButtonPressed{
                                if tempModel.daysActive.contains(7){
                                    removeDay(dayNumber: 7)
                                }
                                else{
                                    tempModel.daysActive.append(7)
                                }
                                print(tempModel.daysActive)
                            }
                        }, label: {
                            
                            if tempModel.daysActive.contains(7){
                                ZStack{
                                    editButtonColor.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Pazar")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            }
                            else {
                                ZStack{
                                    Color.white.edgesIgnoringSafeArea(.all).cornerRadius(10)
                                    
                                    Text("Pazar")
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                .drawBorder(color: .black)
                            }
                        })
                        .frame(minWidth:120,maxWidth: 150) //width:80,height:40)
                        .frame(height:40)
                        .padding()
                        
                        Spacer()

                    }
                    .padding(.horizontal)
                    
                }
  
            }
            .cornerRadius(25)
            .padding()
            
        }
        
    }
    

    
   /*
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80, maximum: 100))], spacing: 20 ) {
        ForEach(CustomerModel().monthsPayed, id: \.self) { // userViewModel.userModel.customers
            datee in
        }
    }
    */
    

    
   
    var body: some View {
        ZStack{
            Color(0xf2f1f6).edgesIgnoringSafeArea(.all)
            VStack{
                
                Picker(selection: $selection, label: Text(""), content: {
                                Text("General").tag(0)
                                Text("History").tag(1)
                }).pickerStyle(.segmented)
                    .padding(.bottom,10)
                    .padding(.horizontal,25)
                
                ScrollView {
                    
                    Spacer()
                    
                    /*
                    Text(userViewModel.userModel.institutionId)
                    Text(userViewModel.userModel.password)
                    */
                    //Text(customerModel.name)
                    if selection == 0 {
                        showInfoView
                    }
                    if selection == 1 {
                        historyView
                        

                    }
                    
                    
                    Spacer()
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
                //.drawBorder(color: .black)
                
                //TextField("",value: $customerModel.age,formatter:NumberFormatter())
                //Text(customerModel.age)
                
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {Button(action: {
                    if true{
                        // updateFirebase(customerModel:customerModel,new:tempModel)
                        userViewModel.updateCustomerInfo(new: tempModel)
                        customerModel = tempModel
                        presentationMode.wrappedValue.dismiss()
                    }
                    else{
                        showAlert1 = true
                    }
                    
                    // userViewModel.changeCustomer(tempModel) -> goes to "customers->institution_id->customer_id" and changes it with tempModel.
                    
                    
                },
                       label: {Text("Save")})})
            }
        }
        .alert("You can save only in edit mode.", isPresented: $showAlert1, actions: {
            Button(action: {showAlert1 = false}, label: {Text("OK")})
        })
    }
}



struct DetailedCustomerView_Previews: PreviewProvider {
    static var custMod = CustomerModel()
    
    static var previews: some View {
        DetailedCustomerView(userViewModel: UserViewModel(),customerModel: .constant(CustomerModel()))
    }
}

