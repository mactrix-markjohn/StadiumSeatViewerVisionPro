/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main app class.
*/

import SwiftUI
import RealityKitContent

@main
struct EntityGestureApp: App {
    
    // The view model.
    @State private var model = ViewModel()
    
    // The immersion styles for different modules.
    @State private var orbitImmersionStyle: ImmersionStyle = .mixed
    @State private var solarImmersionStyle: ImmersionStyle = .full
    
    init() {
        RealityKitContent.GestureComponent.registerComponent()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 5, height: 5, depth: 5, in: .meters)
        
        
        
        
        
        // An immersive Space that shows the Earth, Moon, and Sun as seen from
        // Earth orbit.
        ImmersiveSpace(id: Module.solar.name) {
            SolarSystem()
                .environment(model)
        }
        .immersionStyle(selection: $solarImmersionStyle, in: .full)
    }
    
    
    
}
