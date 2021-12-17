//
//  ARFApp.swift
//  ChristmasLandAR
//
//  Created by Daniel St Vincent on 11/1/21.
//

import SwiftUI
import Firebase

@main
struct ARFApp: App {
    @StateObject var placementSettings = PlacementSettings()
    
    init() {
        FirebaseApp.configure()
        
        //Anonymous authentication with firebase
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else {
                print("FAILED: Anonymous with Firebase.")
                return
            }
                let uid = user.uid
                print(" Firebase: Anonyous user authentication with uid: \(uid).")
            }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
        }
    }
}
