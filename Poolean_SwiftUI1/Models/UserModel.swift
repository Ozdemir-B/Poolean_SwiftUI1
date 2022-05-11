//
//  UserModel.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 10.04.2022.
//

import Foundation

struct UserModel:Codable, Identifiable {
    
    // Just a model of the app. Nothing more.
    // Doesn't contain any functionality.
    var id:String // = UUID().uuidString // ???
    var type:Int// 0:admin , 1:regular
    var name:String
    var institutionId:String
    var password:String // String?
    var email:String?
    //var customerViewModels:[CustomerViewModel] = []
    var customers:[CustomerModel]
    //var customers:[String] = [] // Array of strings(UUID().uuidString)    //[CustomerModel?] = [] // List of Customer UUID().uuidString typed Strings
    //var isFilled:Bool = false
    //var adminSettings:AdminUserSettings?
    
    init(id:String,name:String,institutionId:String,password:String,type:Int,email:String){
        self.id=id
        self.name=name
        self.institutionId=institutionId
        self.password = password
        self.type = type
        self.email = email
        self.customers = [] // CustomerModel(),CustomerModel(),CustomerModel(),CustomerModel(),CustomerModel(),CustomerModel()
        
    }
    
    init(){
        self.id = UUID().uuidString
        self.type = 0
        self.name = "Berkay Ozdemir Admin"
        self.institutionId = "Berkay Kapalı Havuz"
        self.password = "Berkay123"
        self.email = "Berkay@gmail.com"
        self.customers = [CustomerModel(),CustomerModel(),CustomerModel(),CustomerModel(),CustomerModel(),CustomerModel()]
    }
    
}
