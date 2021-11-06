//
//  Model.swift
//  ChristmasLandAR
//
//  Created by Daniel St Vincent on 10/30/21.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case Base
    case Tree
    case Lights
    case Topper
    
    var label: String {
        get {
            switch self {
            case .Base:
                return "Base"
            case .Tree:
                return "ChristmasTree"
            case .Lights:
                return "lights"
            case .Topper:
                return "Topper"
            }
        }
    }
}

class Model {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
func asynLoadModelEntity() {
 let filename = self.name + ".usdz"

        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in

                switch loadCompletion {
                case .failure(let error): print("Unable to load modelEntity for \(filename).Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
                                                
            }, receiveValue: { modelEntity in

                    self.modelEntity = modelEntity
                    self.modelEntity?.scale *= self.scaleCompensation

                    print("ModelEntity for \(self.name) has been loaded.")
                })
 }
            }
                  
struct Models {
    var all: [Model] = []

    init() {
        //Base
        let Base = Model(name: "Base", category: .Base, scaleCompensation:
                                0.100/100)
        self.all += [Base]
        
        //Tree
        let Tree = Model(name: "Tree", category: .Base, scaleCompensation:
                                0.100/100)
        self.all += [Tree]
        
        //Lights
        let Lights = Model(name: "Lights", category: .Base, scaleCompensation:
                                0.100/100)
        self.all += [Lights]
        
        //Topper
        let Star = Model(name: "Star", category: .Base, scaleCompensation:
                                0.100/100)
        self.all += [Star]
    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter( {$0.category == category})
    }
}
