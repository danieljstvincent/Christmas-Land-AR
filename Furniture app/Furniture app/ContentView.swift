//
//  ContentView.swift
//  Furniture app
//
//  Created by Daniel St Vincent on 10/21/21.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    
    @State private var
        isControlsVisible: Bool = true
 
    var body: some View {
        ZStack(alignment: .bottom) {
            
            ARViewContainer()

            
            ControlView()
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ARViewContainer:
    UIViewRepresentable {
    
    func makeUIView(context: Context) ->
        ARView {
       
        let arView = ARView(frame: .zero)
        
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
} 
