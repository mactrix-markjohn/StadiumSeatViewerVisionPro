/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The model content for the solar system module.
*/

import SwiftUI
import RealityKit
import RealityKitContent

/// The model content for the solar system module.
struct SolarSystem: View {
    @Environment(ViewModel.self) private var model
    
    var scale: Float = 80 //25
    var position: SIMD3<Float> = .zero //SIMD3<Float>(25.0, 0.0, 0.1)
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    /// The sun entity that the view creates and stores for later updates.
    @State private var sun: Entity?
    @State private var seat: Entity?
    
    
    //static let markersQuery = EntityQuery(where: .has(SeatPivotComponent.self))
    

    var body: some View {
        
        
        ZStack {
            RealityView { content in
               
//                guard let sun = await WorldAssets.entity(named: "Moon") else {
//                    return
//                }
                
                
                if let sun = try? await Entity(named: "Moon", in: realityKitContentBundle){
                    
                    
                    //async let environment = EnvironmentResource(named: "Sunlight")
                    
                    //let seatname = ["S_202T","S_204T"]
                    
                    //let seatname = ["S_202T","S_204T","S_203T","S_205T","S_206T","S_207T","S_208T","S_209T","S_210T","S_211T","S_212T"]
                    
                    //let seatname = ["S_204T","S_209T"]
                    
                    //let seatname = ["S_202T","S_204T","S_203T","S_209T"]
                    
                    //let seatname = ["Selector_15T","Selector_16T","Selector_1T","Selector_7T"]
                    
                    
                    let seatname = ["Selector_15T","Selector_16T","Selector_1T","Selector_7T","Selector_CenterT"]
                    
                    for name in seatname {
                        
                        guard let seats = sun.findEntity(named: name) else { return }
                        
                        seats.isEnabled = false
                        
                    }
                    
                    //guard let stadium = sun.findEntity(named: "StadiumMenu") else { return }
                    
                    guard let stadium = sun.findEntity(named: "StadiumFullMenu") else { return }
                    
                    stadium.isEnabled = false
                    
                    guard let seatplace = sun.findEntity(named: model.seatNum) else { return }
                    
                    seatplace.isEnabled = true
                    
                    self.seat = seatplace
                    
                    if(model.seatNum == "01")
                        
                    {
                        
                        
                        
                        
                        
                    }else {
                        
                        
                        
                        
                    }
                    
               
                    async let environment = EnvironmentResource(named: "Sunlight")
                    //async let environment = EnvironmentResource(named: "midmorning")
                    
                    //async let environment = EnvironmentResource(named: "IBLSunBig")
                    
                    
                    
                    if let environment = try? await environment {
                        //content.add(satellite)
                        
                        let iblComponent = ImageBasedLightComponent(source: .single(environment), intensityExponent: 0.9)
                        
                        
                        //sun.components.set(ImageBasedLightComponent(source: .single(environment)))
                        
                        sun.components.set(iblComponent)
                        
                        sun.components.set(ImageBasedLightReceiverComponent(imageBasedLight: sun))
                    }
                    
                    
                    content.add(sun)
                    self.sun = sun
                    
                    configure()
                    
                    
                }
                
//
                
                
                
                

            } update: { content in
                configure()
            }
            
            Button {
                Task {
                    
                    seat?.isEnabled = false
        
                    await dismissImmersiveSpace()
                    
                }
            } label: {
                
                Label(
                    "Close Full Space",
                    systemImage: "arrow.down.right.and.arrow.up.left")
                
            }
            
            //Starfield()
            CloudField()
        }
        .onAppear {
            model.isShowingSolar = true
        }
        
//        ZStack {
//            Earth(
//                earthConfiguration: model.solarEarth,
//                satelliteConfiguration: [model.solarSatellite],
//                moonConfiguration: model.solarMoon
//            )
//
//            Sun(
//                scale: 50,
//                position: model.solarSunPosition
//            )
//            
//            Starfield()
//        }
//        .onAppear {
//            model.isShowingSolar = true
//            var announcement = AttributedString("Entered the immersive star filled solar system!")
//            announcement.accessibilitySpeechAnnouncementPriority = .high
//            AccessibilityNotification.Announcement(announcement).post()
//        }
//        .onDisappear {
//            model.isShowingSolar = false
//        }
    }
    
    /// Configures the model based on the current set of inputs.
    private func configure() {
        sun?.scale = SIMD3(repeating: scale)
        sun?.position = position
        
    }
}
