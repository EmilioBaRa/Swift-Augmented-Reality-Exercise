//
//  ContentView.swift
//  Lab8_2022
//
//  Created by ICS 224 on 2022-03-15.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    let worldAnchor = try! Experience.loadWorld()
    @State var hits : Int = 0;
    
    var body: some View {
        ARViewContainer(worldAnchor: worldAnchor, hits: $hits).edgesIgnoringSafeArea(.all)
        VStack{
            Text("Number of Hits: \(hits)")
            Button("Orbit!") {
                worldAnchor.notifications.orbitBattery.post();
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    let worldAnchor : Experience.World;
    @Binding var hits : Int;
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        self.worldAnchor.actions.soldierToyWasHit.onAction = {
            entity in print("Toy soldier was Hit")
            hits+=1;
        }
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(worldAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
