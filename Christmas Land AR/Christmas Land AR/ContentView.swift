//
//  ContentView.swift
//  Christmas Land AR
//
//  Created by Daniel St Vincent on 10/12/21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
        var models: [String] = ["05whh_christmasstree","01akar-icons_circle-plus","04ei_camera","03bx_bx-save", "02bi_question-circle"]
    
//    var models: [String] = ["ChristmasIcon" , "AddOnIcon" ,"CameraIcon","SaveIcon","QuestionMark"]
//   
//    var ChristmasIcon: [String] = ["05whh_christmasstree"]
//    var AddOnIcon: [String] = ["01akar-icons_circle-plus"]
//    var CameraIcon: [String] = ["04ei_camera"]
//    var SaveIcon: [String] = ["03bx_bx-save"]
//    var QuestionMark: [String] = ["02bi_question-circle"]

    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(0 ..< self.models.count) {
                        index in
                        Button(action: {
                            print("DEBUG: selected model with name:\(self.models[index])")
                    }) {
                            Image(uiImage:
                                    UIImage(named:
                                    self.models[index])!)
                                    .resizable()
                                    .frame(height: 50)
                                    .aspectRatio(1/1,
                                    contentMode: .fit)
                     
                        }
                    }
                }
                .padding(5)
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

// DEBUG: This Code
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//endif
