//
//  PlacementView.swift
//  ChristmasLandAR
//
//  Created by Daniel St Vincent on 11/1/21.
//

import SwiftUI

struct PlacementView: View {
    @EnvironmentObject var placementSetting: PlacementSettings

    var body: some View {
        HStack{
            
            Spacer()
            
            PlacementButton(systemIconName: "xmark.circle.fill") {
                print("Cancel Placement button pressed.")
                self.placementSetting.selectedModel = nil
            }
            
            Spacer()
            
            PlacementButton(systemIconName: "checkmark.circle.fill") {
                print("Confirm Placement button pressed.")
                
                self.placementSetting.confirmedModel = self.placementSetting.selectedModel
                
                self.placementSetting.selectedModel = nil
            }
            
            Spacer()
        }
        .padding(.bottom, 30)
    }
}
struct PlacementButton: View {
    let systemIconName: String
    let action: ()-> Void
    
    var body: some View {
        
        Button(action: {
            self.action()
        }) {
            Image(systemName: systemIconName)
                .font(.system(size: 50, weight: .light, design: .default))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 75, height: 75)
    }
}
