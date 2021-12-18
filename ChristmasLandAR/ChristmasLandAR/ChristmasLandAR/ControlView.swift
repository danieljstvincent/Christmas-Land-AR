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

struct playSound: View {
    @State private var isOn = false

    var body: some View {
        VStack {
            Button(action: {
                if isOn == false {
                    SoundManager.playSound(key: "christmasStoryMusic")
                } else {
                    SoundManager.stopPlaying()
                }
                isOn.toggle()
            })
            {
                Image(systemName: isOn ? "speaker" : "speaker.slash")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct CheckToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "speaker" : "speaker.slash")
                //                    .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ControlButtonBar: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var showBrowse: Bool
    @State var showSheet: Bool = false
    
    var body: some View {
        HStack {
            
//            MostRecentlyPlacedButton().hidden(self.placementSettings.recentlyPlaced.isEmpty)
            
            
            // MARK: ChristmasTree ------------------------------
            
            Button(action: {
                showSheet.toggle()
                
            }){
                Image( "05christmasstree")
                
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
            .frame(width: 50, height: 50)
            
            .sheet(isPresented: $showSheet, content: {
                BrowseView(showBrowse: $showBrowse)
            })

//            Button(action: {
//                print("MostRecentlyPlaced button pressed")
//
//            }){
//                Image( "05christmasstree")
//                    .font(.system(size: 35))
//                    .foregroundColor(.white)
//                    .buttonStyle(PlainButtonStyle())
//            }
//            .frame(width: 50, height: 50)
            
            Spacer()
            
            // MARK: Camera ----------------------------
            Button(action: {
                print("MostRecentlyPlaced button pressed")
                
            }){
                Image(systemName: "camera")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
            .frame(width: 50, height: 50)
        
            Spacer()
            
            // MARK: Speaker Button Icon --------------------------
            Button(action: {
                print("MostRecentlyPlaced button pressed")
                
            }){
                Image(systemName:  "speaker")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
            .frame(width: 50, height: 50)
    
            // MARK: Speaker Image ------

            
            Spacer()
            Button (action: {
                print("Setting button pressed")
                
            }){      
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
            .frame(width: 50, height: 50)
            
            playSound()
            
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.red.opacity(0.75))
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

struct MostRecentlyPlacedButton: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    var body: some View{
        Button(action: {
            print("Most Recently Placed button pressed.")
            self.placementSettings.selectedModel = self.placementSettings.recentlyPlaced.last
        }){
            if let mostRecentlyPlacedModel = self.placementSettings.recentlyPlaced.last {
                Image(uiImage: mostRecentlyPlacedModel.thumbnail)
                    .resizable()
                    .frame(width: 46)
                    .aspectRatio(1/1, contentMode: .fit)
            } else {
                Image(systemName: "clock.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(width: 50, height: 50)
        .background(Color.white)
        .cornerRadius(8.0)
    }
}
