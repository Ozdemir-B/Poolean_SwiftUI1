//
//  Poolean_SwiftUI1App.swift
//  Poolean_SwiftUI1
//
//  Created by Berkay Özdemir on 25.03.2022.
//

import SwiftUI
import Firebase

@main
struct Poolean_SwiftUI1App: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
