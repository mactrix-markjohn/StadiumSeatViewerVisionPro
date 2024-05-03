/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The app's main SwiftUI view.
*/

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    let displayTextLeft = """
Yellow:
Orange:
Beige:
Red:
Pink:
Cyan:
Green:
Blue:
"""
    
    let displayTextRight = """
Pivot Drag, Scale, or Rotate
Orientation Preserving Pivot Drag, Scale, or Rotate
Straight Drag, Scale, or Rotate
Pivot Drag Only
Orientation Preserving Pivot Drag only
Straight Drag Only
Scale Only
Rotate Only
"""
   
    @Environment(ViewModel.self) private var model
    @Environment(\.scenePhase) private var scenePhase
       @Environment(\.openWindow) private var openWindow
       @Environment(\.dismissWindow) private var dismissWindow
       @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var scale: Float = 0.45
       //var position: SIMD3<Float> = .zero
    var position: SIMD3<Float> = SIMD3<Float>(0, -1.3, 0.5)
       
       @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    /// The sun entity that the view creates and stores for later updates.
        @State private var scene: Entity?
    
    var body: some View {
        VStack {
//            HStack {
//                Text(displayTextLeft)
//                    .multilineTextAlignment(.trailing)
//                    .font(.system(size: 100))
//                Spacer()
//                Text(displayTextRight)
//                    .multilineTextAlignment(.leading)
//                    .font(.system(size: 100))
//            }
//            .frame(width: 2600)
            
            Spacer()
            RealityView { content in
                // Add the initial RealityKit content
//                if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
//                    content.add(scene)
//                }
                
                if let scene = try? await Entity(named: "Moon", in: realityKitContentBundle) {
                    
                    
                    let seatname = ["Selector_15T","Selector_16T","Selector_1T","Selector_7T","Selector_CenterT"]
                    
                    for name in seatname {
                        
                        guard let seatplace = scene.findEntity(named: name) else { return }
                        
                        seatplace.isEnabled = false
                        
                    }
                    //let seatButton = ["S_202","S_204","S_203","S_209"]
                    
                    let seatButton = ["Selector_1","Selector_15","Selector_16","Selector_7", "Selector_Center"]
                                        
                                        //let seatButton = ["Selector_1","Selector_15","Selector_16","Selector_7_geometr"]
                    for name in seatButton {
                        
                        guard let seatB = scene.findEntity(named: name) else { return }
                        
                        seatB.components.set(HoverEffectComponent())
                        
                    }
                    
                    
                    
                    
                    content.add(scene)
                    
                    self.scene = scene
                    configure()
                }
                
                
            } update: { content in
                
                configure()
            }
            .installGestures()
            .gesture(TapGesture().targetedToAnyEntity().onEnded {
                value in
                
                print("Tapped entity \(value.entity)!")
                
                model.seatNum = "\(value.entity.name)T"
                
                print(model.seatNum)
                
                Task { await openImmersiveSpace(id: Module.solar.name)
                    
                }
                
            
                
            })
        }
        .opacity(model.isShowingSolar ? 0 : 1)
        
        SolarSystemControls()
            .opacity(model.isShowingSolar ? 1 : 0)
    }
    
    private func configure() {
            scene?.scale = SIMD3(repeating: scale)
            scene?.position = position
        }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
