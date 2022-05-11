//
//  CustomerViewModel.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 15.04.2022.
//

import Foundation

class HomeScreenViewModel:ObservableObject {
    
    
    @Published var customers:[CustomerModel] = []
    
    func fetchData() {
        //fetch dustomer data on click (when user taps on customer view, that view will get larger and customer info will be shown there)
    }
}
