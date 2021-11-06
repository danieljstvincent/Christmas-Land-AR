//
//  ControlView.swift
//  Furniture app
//
//  Created by Daniel St Vincent on 10/21/21.
//

import SwiftUI

struct ControlView: View {
    @Binding var isControlsVisible: Bool
    @Binding var showBrowse: Bool

    
    var body: some View{
        VStack {
        
            ControlVisibilityToggleButton(isControlsVisible: $isControlsVisible)
            
            Spacer()

            if isControlsVisible {
                ControlButtonBar(showBrowse: $showBrowse)
            }
        }
    }
}
struct ControlVisibilityToggleButton: View {
    @Binding var isControlsVisible: Bool

    var body: some View {
        HStack {
     
            Spacer()
            
            ZStack {
                
                Color.black.opacity(0.25)
                
                Button(action: {
                    print("Control Visibility Toggle Button pressed.")
                    self.isControlsVisible.toggle()
                }) {
                    Image(systemName: self.isControlsVisible ? "rectangle" : "slider.horizontal.below.rectangle")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8.0)
        }
        .padding(.top, 45)
        .padding(.trailing, 20)
    }
}

struct ControlButtonBar: View {
    @Binding var showBrowse: Bool
    @State var showSheet: Bool = false
    
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
            
            // Browse Button
            Button(action: {
                showSheet.toggle()

            }){
                Image(systemName: "square.grid.2x2")
                
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
            .frame(width: 50, height: 50)
            
            .sheet(isPresented: $showSheet, content: {
                BrowseView(showBrowse: $showBrowse)
            })
            Spacer()

            Button(action: {
                print("Setting button pressed")

            }){
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
            .frame(width: 50, height: 50)

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

