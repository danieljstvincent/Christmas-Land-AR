//
//  ARFApp.swift
//  ChristmasLandAR
//
//  Created by Daniel St Vincent on 11/1/21.
//

import SwiftUI

@main
struct ARFApp: App {
    @StateObject var placementSettings = PlacementSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
        }
    }
}
