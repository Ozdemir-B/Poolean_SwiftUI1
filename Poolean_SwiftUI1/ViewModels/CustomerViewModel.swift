//
//  CustomerViewModel.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 17.04.2022.
//

import Foundation


class CustomerViewModel:ObservableObject {
    
    @Published var id:String
    @Published var model:CustomerModel?
    
    init(_ id:String) {
        self.id = id
        // self.fetchData(id) // fills the CustomerModel
    }
    
    func fetchData(_ id:String){
        //fetchDataFromFirebase
        print("Model fetching from firebase for customer id :\(self.id) ")
    }

}
