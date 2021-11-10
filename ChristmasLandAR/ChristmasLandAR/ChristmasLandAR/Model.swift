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
    case Ornunments
    case Topper
    
    var label: String {
        get {
            switch self {
            case .Base:
                return "Bases"
            case .Tree:
                return "Trees"
            case .Lights:
                return "lights"
            case .Ornunments:
                return "Ornument"
            case .Topper:
                return "Toppers"
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
        let TreeBase = Model(name: "Base", category: .Base, scaleCompensation:
                                0.32/100)
        self.all += [TreeBase]
        
        //Tree
        let EmptyTree = Model(name: "Tree", category: .Tree, scaleCompensation:
                                0.32/100)
        
        let ChristmasTree = Model(name: "ChristmasTree", category: .Tree, scaleCompensation:
                                0.32/100)
        
        self.all += [EmptyTree, ChristmasTree]
        
        //Lights
        let ChristmasLights = Model(name: "Lights", category: .Lights, scaleCompensation:
                                0.32/100)
        self.all += [ChristmasLights]
        
        //Topper
        let ChristmasStar = Model(name: "Star", category: .Topper, scaleCompensation:
                                0.32/100)
        self.all += [ChristmasStar]
        

    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter( {$0.category == category})
    }
}
