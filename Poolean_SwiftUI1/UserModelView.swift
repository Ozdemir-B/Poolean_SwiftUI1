//
//  UserModelView.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 10.04.2022.
//

import Foundation

class UserModelView:ObservableObject {
    
    
    
    
    func fetchData(institution_id:String, pass:String){
        // api call or firebase etc..
        let url = URL(string: "http://192.168.252.223:5001/login")
        var request = URLRequest(url:url!)
        
        /*request.setValue("institution_id", forHTTPHeaderField: <#T##String#>)*/
        let body = ["institution_id": institution_id,"password":pass]
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        request.httpMethod = "POST"
        request.httpBody = bodyData
        
        // Create the HTTP request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in

            if let error = error {
                // Handle HTTP request error
            } else if let data = data {
                // Handle HTTP request response
            } else {
                // Handle unexpected error
            }
        }
        
        task.resume()
        
        task.cancel()
        
    }
    
}
