//
//  PlacementSettings.swift
//  ChristmasLandAR
//
//  Created by Daniel St Vincent on 10/31/21.
//

import Swift
import RealityKit
import Combine

class PlacementSettings: ObservableObject {
    
    // When the user selects a model in BrowseView, this propoerty is set.
    @Published var selectedModel: Model? {
        willSet(newValue) {
            print("setting selectedModel to \(String(describing: newValue?.name))")
        }
    }
    
    // When the user taps confirm in placementView, the value of selectedModel is assigned to confirmedModel
    @Published var confirmedModel: Model? {
        willSet(newValue) {
            guard let model = newValue else {
                print("Clearing confirmedModel")
                return
            }
            print("Setting confirmedModel to \(model.name)")
            
            self.recentlyPlaced.append(model)
        }
    }
    //This property retains a record of placed models in the scene. The last element in the array is the most recently placed model.
    @Published var recentlyPlaced: [Model] = []
    // This property retains the cancellable onject for our SceneEvents.Upload
    var sceneObserver: Cancellable?
}
