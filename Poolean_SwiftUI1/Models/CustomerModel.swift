//
//  CustomerModel.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 15.04.2022.
//

import Foundation


struct CustomerModel:Codable, Identifiable{
    
    var id:String // = UUID().uuidString
    var name:String
    var age:Int
    var weight:Double
    var height:Double
    var daysActive:[Int] //1:Pazartesi,..., 7:Pazar
    var monthsPayed:[String] // Dates on the list will be the payed months automaticly (only months and years) "mm-yyyy-amount"
    //var daysDone:[Date]// Dates on the list will be shown in calender view or in a listView as highlgihted (days months years) ??
    
    init(id:String,name:String,age:Int,weight:Double,height:Double,daysActive:[Int],monthsPayed:[String]){
        self.id = id
        self.name = name
        self.age = age
        self.weight = weight
        self.height = height
        self.daysActive = daysActive
        self.monthsPayed = monthsPayed
        
    }
    
    init(){
        self.id = UUID().uuidString//""//ididididid1231232132132"
        self.name = "Berkay Ozdemir"//Berkay Ozdemir"
        self.age = 12
        self.weight = 50
        self.height = 150
        self.daysActive = [1,3,5]
        self.monthsPayed = ["11-2021-200","5-2020-180","3-2022-250","4-2022-260"]
        //self.daysDone = []
    }
    //var trainer:UserModel?
    // other customer info like statistics,
}



