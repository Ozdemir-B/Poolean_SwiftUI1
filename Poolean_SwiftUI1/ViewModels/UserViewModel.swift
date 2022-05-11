//
//  UserViewModel.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 12.04.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase
//import Firebase


class UserViewModel: ObservableObject { // CONNECTS FIREBASE AND FETCHES USER DATA (UserModel). THAT'S IT.
    
    @Published var showLoginPage:Bool = false
    @Published var showSigninPage:Bool = false
    @Published var isUserFilled:Bool = false
    //@Published var userDataResponse:
    @Published var userModel:UserModel = UserModel()//returnRandomUserModel(name: "Ahmet Kaya", institution_id: "Ahmet_Havuz", password: "Ahmet123", email: "Ahmet@gmail.com", type: 0) //UserModel()
    
    
    func returnRandomUserModel(name:String,institution_id:String, password:String,email:String,type:Int)->UserModel {
        var user:UserModel = UserModel()
        //user.id = UUID().uuidString
        user.name = name
        user.institutionId = institution_id
        user.password=password
        user.email = email
        user.type = type
        user.customers = [CustomerModel(),CustomerModel(),CustomerModel(),CustomerModel(),CustomerModel(),CustomerModel()]
        return user
    }
    

    
    func addNewInstitution(name:String,institutionId:String,password:String,type:Int,email:String){
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(institutionId)
        
        ref.setData([password:["id":UUID().uuidString,"name":name,"password":password,"email":email,"institutionId":institutionId,"type":type]],merge:true) {
            error in
            if let error = error {
                print("------------------ error-addNewInstitution-------------------")
                
                print(error.localizedDescription)
                print("-------------------------------------------------------------")
            }
        }
        
    }
    
    func addRegularUser(name:String,institutionId:String,password:String,email:String){
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(institutionId)
        
        
        
        ref.setData([password:["id":UUID().uuidString,"name":name,"password":password,"email":email,"institutionId":institutionId,"type":1]],merge:true) {
            error in
            if let error = error {
                print("------------------ error-addNewInstitution-------------------")
                
                print(error.localizedDescription)
                print("-------------------------------------------------------------")
            }
        }
    }
    

    
    func addCustomerToInstitution(name:String,age:Int,weight:Double,height:Double,daysActive:[Int],monthsPayed:[String]){
        let db = Firestore.firestore()
        let ref = db.collection("Customers").document(self.userModel.institutionId)
        let id = UUID().uuidString
        self.userModel.customers.append(CustomerModel(id: id, name: name, age: age, weight: weight, height: height, daysActive: daysActive, monthsPayed: monthsPayed))
        ref.setData([id:["id": id, "name": name, "age": age, "weight": weight, "height": height, "daysActive": daysActive, "monthsPayed": monthsPayed]], merge: true){
            error in
            if let error = error {
                print("------------------ error-addNewInstitution-------------------")
                
                print(error.localizedDescription)
                print("-------------------------------------------------------------")
            }
        }
    }
    
    func fetchCustomersOfInstitution(institutionId:String) -> Bool{
        var custModelArray:[CustomerModel] = []
        let db = Firestore.firestore()
        let ref = db.collection("Customers")
        var resultValue = false
        ref.getDocuments(completion: {
            snapshot, error in
            self.userModel.customers.removeAll()
            guard error == nil else{
                print("------------- error ------------")
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                
                for document in snapshot.documents {
                    if document.documentID == institutionId{
                        
                        let data0 = document.data()
                        
                        for d in data0{
                            
                            let data = d.value as? [String:AnyObject]
                            self.userModel.customers.append(CustomerModel(id: data!["id"] as! String, name: data!["name"] as! String, age: data!["age"] as! Int, weight: data!["weight"] as! Double, height: data!["height"] as! Double, daysActive: data!["daysActive"] as! [Int], monthsPayed: data!["monthsPayed"] as! [String]))
                            resultValue = true
                            /*
                            let data = document.data() as! [String:AnyObject]
                            
                            self.userModel.customers.append(CustomerModel(id: data["id"] as! String, name: data["name"] as! String, age: data["age"] as! Int, weight: data["weight"] as! Double, height: data["height"] as! Double, daysActive: data["daysActive"] as! [Int], monthsPayed: data["monthsPayed"] as! [String]))
                             */
                            //print(custModelArray)
                            
                            
                        }
                    }
                }
            }
        })
        return resultValue
    }
    
    func updateCustomerInfo(new:CustomerModel){
        let db = Firestore.firestore()
        let ref = db.collection("Customers").document(self.userModel.institutionId)
        
        //ref.updateData([customerModel.id:[]])
        //self.userModel.customers.append(CustomerModel(id: id, name: name, age: age, weight: weight, height: height, daysActive: daysActive, monthsPayed: monthsPayed))
        ref.updateData([new.id:["id": new.id, "name": new.name, "age": new.age, "weight": new.weight, "height": new.height, "daysActive": new.daysActive, "monthsPayed": new.monthsPayed ]]){
            error in
            if let error = error {
                print("------------------ error-addNewInstitution-------------------")
                print(error.localizedDescription)
                print("-------------------------------------------------------------")
            }
        }
    }
    
    
    
    func fetchUsersFirestore(){
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(self.userModel.institutionId)
        
        
    }
    
    
    
    func firestoreLogin(institutionId:String, password:String) -> Bool {
        let db = Firestore.firestore()
        //let ref = db.collection("Users/\(institutionId)")
        let ref = db.collection("Users")
        var returnValue:Bool = false
        
        ref.getDocuments(completion: {
            snapshot, error in
            
            guard error == nil else{
                print("-------------------ERROR---------------------------------")
                print(error!.localizedDescription)
                print("----------------------------------------------------")
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents{
                    //print("----------------------------------------------------")
                    //let data = document.data()
                    
                    if document.documentID == institutionId{
                        print("documentId:\(document.documentID)")
                        let data = document.data()
                        for d in data{
                            if d.key == password{
                                print("d.key:\(d.key) , value:::")
                                print(d.value)
                                print(type(of: d))
                                print(type(of: d.value))
                                
                                let d_forced = d.value as? [String:AnyObject] // type casting like in C#.Net
                                print(d_forced!["name"] as! String)
                                //let data_value = d.value ?? []
                                self.userModel = UserModel(id: d_forced!["id"] as! String, name: d_forced!["name"] as! String, institutionId: d_forced!["institutionId"] as! String, password: d_forced!["password"] as! String, type: d_forced!["type"] as! Int, email: d_forced!["email"] as! String)
                                self.fetchCustomersOfInstitution(institutionId: institutionId)
                                //print(self.userModel.customers)
                                self.isUserFilled = true
                                returnValue = true
                            }
                        }
                    }
                    //print(data)
                    print("----------------------------------------------------")
                }
            }
        })
        return returnValue
    }
    

    
    func fetchUser(institutionId:String,password:String){

    }
    
    /*
    init(){
        self.userModel = returnRandomUserModel(name: "Ahmet Kaya", institution_id: "Ahmet_Havuz", password: "Ahmet123", email: "Ahmet@gmail.com", type: 0)
        
    }
     */
    
    

    
   

    //@Published var customers:[CustomerModel] = []
    
    private var db = Firestore.firestore()
    
    func fetchFirestore(){
        
    }
    

    func deneme(){
        
        print(userModel.institutionId)
        self.isUserFilled = true
        
    }
    
    func fetchData() {
        let session = URLSession.shared
        let myapi:String = "http://192.168.1.63:5001/login"
        let aragoraapi:String = "https://arogora.herokuapp.com/"
        
        let url = URL(string: aragoraapi)!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in

        // Do something…
            //print(data!)
            
            /*if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
                print(json)
            }*/
            // if response.code == 200 {do something}
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("")
                print(type(of: json))
                print("")
                self.isUserFilled = true
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
            //print(response!)
        })
        task.resume()
    }
    
    

}
