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
    @Published var showAllUsersAppeared:Bool = false
    //@Published var userDataResponse:
    @Published var userModel:UserModel = UserModel()//returnRandomUserModel(name: "Ahmet Kaya", institution_id: "Ahmet_Havuz", password: "Ahmet123", email: "Ahmet@gmail.com", type: 0) //UserModel()
    @Published var usersList:[UserModel] = [UserModel(),UserModel()]
    
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
        
        ref.setData([password:["id":UUID().uuidString,"name":name,"password":password,"email":email,"institutionId":institutionId,"type":0]],merge:true) {
            error in
            if let error = error {
                print("------------------ error-addNewInstitution-------------------")
                
                print(error.localizedDescription)
                print("-------------------------------------------------------------")
            }
        }
        
    }
    
    func addRegularUser(name:String,institutionId:String,password:String,email:String,type:Int){
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
                        resultValue = true
                    }
                }
            }
        })
        return resultValue
    }
    
    func fetchUsersOfInstitution() -> Bool{
        self.usersList.removeAll()
        let institutionId = self.userModel.institutionId
        var custModelArray:[CustomerModel] = []
        let db = Firestore.firestore()
        let ref = db.collection("Users")
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
                            if d.key != self.userModel.password{
                                let d_forced = d.value as? [String:AnyObject] // type casting like in C#.Net
                                print(d_forced!["name"] as! String)
                                //let data = d.value as? [String:AnyObject]
                                self.usersList.append(UserModel(id: d_forced!["id"] as! String, name: d_forced!["name"] as! String, institutionId: d_forced!["institutionId"] as! String, password: d_forced!["password"] as! String, type: d_forced!["type"] as! Int, email: d_forced!["email"] as! String))
                                print("--userslist--")
                                resultValue = true
                                /*
                                let data = document.data() as! [String:AnyObject]
                                
                                self.userModel.customers.append(CustomerModel(id: data["id"] as! String, name: data["name"] as! String, age: data["age"] as! Int, weight: data["weight"] as! Double, height: data["height"] as! Double, daysActive: data["daysActive"] as! [Int], monthsPayed: data["monthsPayed"] as! [String]))
                                 */
                                //print(custModelArray)
                            }
                            
                            
                        }
                        resultValue = true
                    }
                }
            }
        })
        return resultValue
    }
    
    
    func fetchUsersOfInstitution2() -> [UserModel] {
        //var usersList:[UserModel] = []
        let institutionId = self.userModel.institutionId
        let password = self.userModel.password
        
        let db = Firestore.firestore()
        //let ref = db.collection("Users/\(institutionId)")
        let ref = db.collection("Users")
        var returnValue:Bool = false
        
        ref.getDocuments(completion: {
            snapshot, error in
            
            guard error == nil else{
                print("-------------------ERROR---------------------------------")
                print(error!.localizedDescription)
                print("----------------!!!ERROR!!!------------------------------")
                return
            }
            
            if let snapshot = snapshot {
                print("-------------------SNAPSHOT---------------------------------")
                for document in snapshot.documents{
                    //print("----------------------------------------------------")
                    //let data = document.data()
                    
                    if document.documentID == institutionId{
                        //print("documentId:\(document.documentID)")
                        let data = document.data()
                        for d in data{
                            if d.key != password{

                                let d_forced = d.value as? [String:AnyObject] // type casting like in C#.Net
                                //print(d_forced!["name"] as! String)
                                //let data_value = d.value ?? []
                                self.usersList.append(UserModel(id: d_forced!["id"] as! String, name: d_forced!["name"] as! String, institutionId: d_forced!["institutionId"] as! String, password: d_forced!["password"] as! String, type: d_forced!["type"] as! Int, email: d_forced!["email"] as! String))
                                print("--userslist--")
                                //print(self.usersList)

                                returnValue = true
                            }
                        }
                    }
                    //print(data)
                    //print("----------------------------------------------------")
                }
                print("----------------!!!SNAPSHOT!!!------------------------------")
                print("----------------USERS LIST :: ")
                //print(self.usersList)
                print("----------------RETURN VALUE _> -> :: \(returnValue)")
                return
            }
            print("----------------RETURN VALUE 222_> -> :: \(returnValue)")
            return
            
        })
        print("----------------RETURN VALUE 333_> -> :: \(returnValue)") // doesn't print that. so that means this function never runs the code below.
        return self.usersList
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
    
    func updateLocalUsersList(new:UserModel){
        for userIndex in self.usersList.indices{
            if self.usersList[userIndex].id == new.id {
                self.usersList.remove(at: userIndex)
                self.usersList.append(new)
            }
        }
    }
    
    func updateUserInfo(new:UserModel){
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(self.userModel.institutionId)
        
        
        
        //ref.updateData([customerModel.id:[]])
        //self.userModel.customers.append(CustomerModel(id: id, name: name, age: age, weight: weight, height: height, daysActive: daysActive, monthsPayed: monthsPayed))
        ref.updateData( [new.password:["id": new.id, "name": new.name, "password":new.password, "institutionId":new.institutionId, "type":new.type,"email":new.email]] ){
            error in
            if let error = error {
                print("------------------ error-addNewInstitution-------------------")
                print(error.localizedDescription)
                print("-------------------------------------------------------------")
            }
        }
    }
    
    func updatePersonalInfo(new:UserModel){
        self.userModel = new
        
        self.updateUserInfo(new: self.userModel)
    }
    
    

    func firestoreLogin2(institutionId:String) -> Bool {
        
        let db = Firestore.firestore()
        //let ref = db.collection("Users/\(institutionId)")
        let ref = db.collection("Users")
        var returnValue:Bool = false
        /*
         DispatchQueue.global().sync {
                     DispatchQueue.main.async {
                     }
                 }
         */
        
        ref.getDocuments(completion:{
            snapshot, error in

            guard error == nil else{
                print("-------------------ERROR---------------------------------")
                print(error!.localizedDescription)
                print("----------------------------------------------------")
                self.loginFetchState = 2 // error
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
                            if true{//d.key == password{
                                print("d.key:\(d.key) , value:::")
                                print(d.value)
                                print(type(of: d))
                                print(type(of: d.value))
                                
                                let d_forced = d.value as? [String:AnyObject] // type casting like in C#.Net
                                print(d_forced!["name"] as! String)
                                //let data_value = d.value ?? []
                                self.usersList.append(UserModel(id: d_forced!["id"] as! String, name: d_forced!["name"] as! String, institutionId: d_forced!["institutionId"] as! String, password: d_forced!["password"] as! String, type: d_forced!["type"] as! Int, email: d_forced!["email"] as! String))
                                //self.fetchCustomersOfInstitution(institutionId: institutionId)
                                //print(self.userModel.customers)
                                returnValue = true
                                
                                //self.isFirestoreLoginDone = true
                                
                            }
                            // fail
                            
                        }
                        
                    }
                    //print(data)
                    
                }
            }
            
            
        })
        return returnValue
    }
    

    
    
    @Published var isFirestoreLoginDone:Bool = false
    @Published var loginFetchState:Int = 0
    func firestoreLogin(institutionId:String, password:String) -> Bool {
        self.isFirestoreLoginDone = false
        let db = Firestore.firestore()
        //let ref = db.collection("Users/\(institutionId)")
        let ref = db.collection("Users")
        var returnValue:Bool = false
        /*
         DispatchQueue.global().sync {
                     DispatchQueue.main.async {
                     }
                 }
         */
        
        ref.getDocuments(completion:{
            snapshot, error in

            guard error == nil else{
                print("-------------------ERROR---------------------------------")
                print(error!.localizedDescription)
                print("----------------------------------------------------")
                self.loginFetchState = 2 // error
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
                                self.fetchUsersOfInstitution()
                                //print(self.userModel.customers)
                                print("-----firestoreLogin() -> isUserFilled 0:: \(self.isUserFilled) ----------")
                                self.isUserFilled = true
                                print("-----firestoreLogin() -> isUserFilled 1:: \(self.isUserFilled) ----------")
                                returnValue = true
                                self.isUserFilled = true
                                self.loginFetchState = 1 // success
                                //self.isFirestoreLoginDone = true
                                break
                            }
                            self.loginFetchState = -1 // fail
                            print("-----firestoreLogin() -> isUserFilled 2:: \(self.isUserFilled) ----------")
                        }
                        print("-----firestoreLogin() -> isUserFilled 2.5:: \(self.isUserFilled) ----------")
                    }
                    //print(data)
                    print("-----firestoreLogin() -> isUserFilled 3:: \(self.isUserFilled) ----------")
                }
                print("-----firestoreLogin() -> isUserFilled 4:: \(self.isUserFilled) ----------")
            }
            print("-----firestoreLogin() -> isUserFilled 5:: \(self.isUserFilled) ----------")
            self.isFirestoreLoginDone = true
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
