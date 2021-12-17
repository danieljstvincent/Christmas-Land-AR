//
//  Model.swift
//  ChristmasLandAR
//
//  Created by Daniel St Vincent on 10/30/21.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: String, CaseIterable {
    case Base
    case Tree
    case Lights
    case Ornaments
    case decor
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
            case .Ornaments:
                return "Ornament"
            case .decor:
                return "decors"
            case .Topper:
                return "Toppers"
            }
        }
    }
}

class Model: ObservableObject, Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var category: ModelCategory
    @Published var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
        
        FirebaseStorageHelper.asyncDownloadToFilesystem(relativePath: "thumbnails\(self.name).png") { localUrl in
            do {
                let imageData = try Data(contentsOf: localUrl)
                self.thumbnail = UIImage(data: imageData) ?? self.thumbnail
            } catch {
                print("Error loading image: \(error.localizedDescription)")
            }
        }
    }
    
    func asynLoadModelEntity() {
        FirebaseStorageHelper.asyncDownloadToFilesystem(relativePath: "models/\(self.name).usdz") { localUrl in
            self.cancellable = ModelEntity.loadModelAsync(contentsOf: localUrl)
                .sink(receiveCompletion: { loadCompletion in
                    
                    switch loadCompletion {
                    case .failure(let error): print("Unable to load modelEntity for \(self.name).Error: \(error.localizedDescription)")
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
}

//struct Models {
//    var all: [Model] = []
//
//    init() {
//        //Base
//        let TreeBase = Model(name: "Base", category: .Base, scaleCompensation:
//                                0.32/100)
//        self.all += [TreeBase]
//        
//        //Tree
//        let EmptyTree = Model(name: "Tree", category: .Tree, scaleCompensation:
//                                0.32/100)
//        
//        let ChristmasTree = Model(name: "ChristmasTree", category: .Tree, scaleCompensation:
//                                0.32/100)
//        
//        self.all += [EmptyTree, ChristmasTree]
//        
//        //Lights
//        let ChristmasLights = Model(name: "Lights", category: .Lights, scaleCompensation:
//                                0.32/100)
//        self.all += [ChristmasLights]
//        
//        //Topper
//        let ChristmasStar = Model(name: "Star", category: .Topper, scaleCompensation:
//                                0.32/100)
//        self.all += [ChristmasStar]
//        
//
//    }
//    
//    func get(category: ModelCategory) -> [Model] {
//        return all.filter( {$0.category == category})
//    }
//}
