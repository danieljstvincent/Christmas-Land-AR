//
//  ControlView.swift
//  Furniture app
//
//  Created by Daniel St Vincent on 10/21/21.
//

import SwiftUI
import RealityKit

struct ControlView: View {

    
    var body: some View{
        VStack {
        
        ControlVisibilityToggleButton()
            
        Spacer()
            
        ControlButtonBar()
        }
    }
}

struct ControlVisibilityToggleButton: View {
    var body: some View {
        HStack {
     
            Spacer()
            
            ZStack {
                
                Color.black.opacity(0.25)
                
                Button(action: {
                    print("Control Visibility Toggle Button pressed.")
                }) {
                    Image(systemName: "rectangle")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8.0)
        }
        .padding(.top, 45)
//        .padding(.training, 20)
    }
}

struct ControlButtonBar: View {
    var body: some View {
        HStack {
            
            Button(action: {
                print("MostRecentlyPlaced button pressed")
                
            }){
                Image(systemName: "clock.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
            .frame(width: 50, height: 50)
            
            Spacer()
            
//            Button(action: {
//                print("Browse button pressed.")
//
//            }){
//                Image(systemName: "square.grid.2x2")
//                    .font(.system(size: 35))
//                    .foregroundColor(.white)
//                    .buttonStyle(PlainButtonStyle())
//            }
//            .frame(width: 50, height: 50)
//
//            Spacer()
//
//            Button(action: {
//                print("Setting button pressed")
//
//            }){
//                Image(systemName: "slider.horizontal.3")
//                    .font(.system(size: 35))
//                    .foregroundColor(.white)
//                    .buttonStyle(PlainButtonStyle())
//            }
//            .frame(width: 50, height: 50)
            
            
            ControlButton(systemIconName: "clock.fill" ) {
                print("MostRecentlyPlaced button pressed.")
            }

            Spacer()

            ControlButton(systemIconName: "square.grid.2x2" ) {
                print("Browse Button pressed.")
            }

            Spacer()

            ControlButton(systemIconName: "slider.horizontal.3" ) {
                print("Setting button pressed.")
            }

        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.green.opacity(0.25))
        }
    }


struct ControlButton: View {
    let systemIconName: String
    let action: ()-> Void
    
    var body: some View {
        
        Button(action: {
            self.action()
        }) {
            Image(systemName: "systemIconName")
                .font(.system(size: 35))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
            .frame(width: 50, height: 50)
    }
}

