//
//  HomeView.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 28.03.2022.
//

import SwiftUI

struct MainScreenView: View {
    @State var showAddCustomerView:Bool = false
    // Hold the state for which tab is active/selected
        @State var selection: Int = 0
        let userType:Int = 0 // 0:Admin 1:Regular
    @StateObject var userViewModel:UserViewModel
         
        var body: some View {
            
            // Your native TabView here
            TabView(selection: $selection) {
                
                HomeScreenView(userViewModel: userViewModel)
                    .fullBackground(imageName: "bg1")
                    .tag(0)
                    .onAppear(perform:{
                        print("HomeScreenView appeared ----- ")
                        
                    })
                    

                
                /*SettingsView()
                    .background(.blue)
                    .tag(1)*/
                
                
                 if userViewModel.userModel.type == 0 {
                     SettingsView(userViewModel: userViewModel)
                         .background(.green)
                         .tag(1)
                 }
                 if userViewModel.userModel.type == 1 {
                     SettingsView(userViewModel:userViewModel)
                         .background(.green)
                         .tag(1)
                 }
                 
                
                
            }
            .overlay( // Overlay the custom TabView component here
                Color.white // Base color for Tab Bar
                    .edgesIgnoringSafeArea(.vertical)
                    .frame(height: 50) // Match Height of native bar
                    .overlay(
                        HStack {
                        Spacer()
                        
                        // First Tab Button
                        Button(action: {
                            self.selection = 0
                        }, label: {
                            Image(systemName: "house.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255)) //.foregroundColor(.white)//Color(red: 32/255, green: 43/255, blue: 63/255))
                                .opacity(selection == 0 ? 1 : 0.4) // if selection == 0 -> 1 else 0.4e
                        })
                        Spacer()
                        
                        // Second Tab Button
                        /*Button(action: {
                            self.selection = 1
                        }, label: {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                                .opacity(selection == 1 ? 1 : 0.4)
                        })
                        
                        Spacer()*/
                        
                        // Third Tab Button
                        Button(action: {
                            self.selection = 1
                        }, label: {
                            Image(systemName: "gear")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(Color(red: 32/255, green: 43/255, blue: 63/255))
                                .opacity(selection == 1 ? 1 : 0.4)
                        })
                        Spacer()
                        
                    })
            ,alignment: .bottom) // Align the overlay to bottom to ensure tab bar stays pinned.
        }
    
}

struct CustomerView : View { // <Content:View>: View {
    
    @Binding var customerModel:CustomerModel
    @StateObject var userViewModel:UserViewModel
    
    var body: some View {

        NavigationLink(
            destination: DetailedCustomerView(userViewModel:userViewModel,customerModel:$customerModel).onAppear(perform: {print("->->->__>--->>> :: DetailedCustomerView appeaered")})
                .onDisappear(perform: {print("DetailedCustomerView Disappeared")}),//DetailedCustomerView(id: id, userViewModel: userViewModel,customerModel: $userViewModel.userModel.customers[0]),
                       label:{
            ZStack(alignment:.leading){
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white.opacity(0.9))
                VStack{
                    Text(customerModel.name)
                        .font(.title2)
                        .fontWeight(.bold)//userViewModel.userModel.institutionId)
                        .foregroundColor(.black)
                        .padding()
                    Spacer()
                }
                //.drawBorder(color: .blue)
            }
            //.drawBorder(color: .black)
            .frame(maxWidth:.infinity, minHeight:150)
            .padding()
        })
        
    }
}

struct DayPickerView: View{
    @Environment(\.presentationMode) var presentationMode
    @Binding var day:Int
    
    var body: some View{
        VStack(alignment:.center){
            
            HStack{
                Text("Pick a Day")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .padding([.top,.leading],10)
                    .padding(.top)
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                day = 0
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Tüm Günler")
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                    .foregroundColor(.green)
            })
            
            VStack{
                Button(action: {
                    day = 1
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Pazartesi")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                })
                .padding()
                
                Button(action: {
                    day = 2
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Salı")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                })
                
                Button(action: {
                    day = 3
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Çarşamba")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                })
                .padding()
                
                Button(action: {
                    day = 4
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Perşembe")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                })
                
                Button(action: {
                    day = 5
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Cuma")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                })
                .padding()
                
                Button(action: {
                    day = 6
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Cumartesi")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                })
                
                
                Button(action: {
                    day = 7
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Pazar")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                })
                .padding()
            }
            
            Spacer()
            
        }
    }
}

struct HomeScreenView : View {
    
    //@StateObject var homeScreenViewModel:HomeScreenViewModel = HomeScreenViewModel()
    @State var showAddCustomerView:Bool = false
    @StateObject var userViewModel:UserViewModel
    @State var todayNumber:Int = 1
    @State var searchText:String = ""
    @State var showAllCustomers:Bool = false
    
    //@State var searchMode:Bool = false
    

    
    
    init(userViewModel:UserViewModel){
        
        self._userViewModel = StateObject(wrappedValue: userViewModel)
        
        
         let x:Int = getDayOfWeek() - 1
         //_todayNumber = State(initialValue: x)//getDayOfWeek() ?? -1)
         // todayNumber:Int , _todayNumber:State<Int>, $todayNumber:Binding<Int>
         print("TODAY:::::::::: ::: -> :: \(self.todayNumber)")
         
    }
    
    func getDayOfWeek() -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.string(from: Date())
        
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return -1 }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        print(weekDay)
        return (weekDay ?? -1)
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment:.center){
                ScrollView {
                    //Color.red.edgesIgnoringSafeArea(.all)
                    
                    /*CustomerView(id:userViewModel.userModel.institutionId,userViewModel: userViewModel)
                    CustomerView(id:"berkay özdemir",userViewModel: userViewModel)
                    */
                    
                    HStack{
                        RoundedTextField1WithButton(text: "search", binding_value: $searchText,background_color: .white.opacity(0.9)){
                            // completion inside
                            //searchMode.toggle()
                            print(searchText)
                            searchText=""
                        }
                        .padding(.leading)
                        .padding(.vertical)
                        
                        VStack{
                            Spacer()
                            Button(action: {
                                showAllCustomers.toggle()
                            }, label: {
                                if todayNumber == 0 {
                                    Text("ALL")
                                        .font(.system(size: 25, weight: .bold, design: .rounded))
                                        .foregroundColor(.green)
                                }
                                if todayNumber == 1 {
                                    Text("Pzrts")
                                        .font(.system(size: 25, weight: .bold, design: .rounded))
                                        .foregroundColor(.green)
                                }
                                if todayNumber == 2 {
                                    Text("Salı")
                                        .font(.system(size: 25, weight: .bold, design: .rounded))
                                        .foregroundColor(.green)
                                }
                                if todayNumber == 3 {
                                    Text("Çarş")
                                        .font(.system(size: 25, weight: .bold, design: .rounded))
                                        .foregroundColor(.green)
                                }
                                if todayNumber == 4 {
                                    Text("Perş")
                                        .font(.system(size: 25, weight: .bold, design: .rounded))
                                        .foregroundColor(.green)
                                }
                                if todayNumber == 5 {
                                    Text("Cuma")
                                        .font(.system(size: 25, weight: .bold, design: .rounded))
                                        .foregroundColor(.green)
                                }
                                if todayNumber == 6 {
                                    Text("Cmrts")
                                        .font(.system(size: 25, weight: .bold, design: .rounded))
                                        .foregroundColor(.green)
                                }
                                if todayNumber == 7 {
                                    Text("Pazar")
                                        .font(.system(size: 25, weight: .bold, design: .rounded))
                                        .foregroundColor(.green)
                                }
                                
                            })
                            .padding(.trailing)
                            .sheet(isPresented: $showAllCustomers) {
                                DayPickerView(day: $todayNumber)
                                }
                            //Text("\(todayNumber)")
                            Spacer()
                        }
                    }
                    
                    
                    if searchText == ""{
                        ForEach(userViewModel.userModel.customers.indices,id: \.self) { indis in
                            if todayNumber != 0{
                                if userViewModel.userModel.customers[indis].daysActive.contains(todayNumber) {
                                    CustomerView(customerModel: $userViewModel.userModel.customers[indis],userViewModel:userViewModel)
                                }
                            }
                            else{
                                CustomerView(customerModel: $userViewModel.userModel.customers[indis],userViewModel:userViewModel)
                            }
                            
                            
                                
                        }
                    }
                    else {
                        ForEach(userViewModel.userModel.customers.indices,id: \.self) { indis in
                            if userViewModel.userModel.customers[indis].name.contains(searchText){
                                //CustomerView(customerModel: $userViewModel.userModel.customers[indis],userViewModel:userViewModel)
                                if todayNumber != 0{
                                    if userViewModel.userModel.customers[indis].daysActive.contains(todayNumber) {
                                        CustomerView(customerModel: $userViewModel.userModel.customers[indis],userViewModel:userViewModel)
                                    }
                                }
                                else{
                                    CustomerView(customerModel: $userViewModel.userModel.customers[indis],userViewModel:userViewModel)
                                }
                            }
    
                        }
                    }
                    /*
                     if !searchMode{
                         ForEach(userViewModel.userModel.customers.indices,id: \.self) { indis in
                             CustomerView(customerModel: $userViewModel.userModel.customers[indis])
                                 
                         }
                     }
                     else {
                         
                     }
                     */


                }

            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {showAddCustomerView=true}, label: {Label("",systemImage:"plus.circle.fill").foregroundColor(.black).font(.title)})
                        .sheet(isPresented: $showAddCustomerView) {
                            AddCustomerView(userViewModel: userViewModel)
                            }
                    //NavigationLink(destination: AddCustomerView(userViewModel: userViewModel),label: {Label("",systemImage:"plus.circle.fill").foregroundColor(.black).font(.title)} )
                })
            }
            //.navigationBarItems(trailing: )
            .navigationTitle(userViewModel.userModel.institutionId ?? "Home Screen Title")
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .topLeading
                )
            .fullBackground(imageName: "bg1")
        }
        
        
        
        
            
    }

    
        //.onDisappear(perform: <#T##(() -> Void)?#>)
    
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(userViewModel:UserViewModel())
    }
}
 
