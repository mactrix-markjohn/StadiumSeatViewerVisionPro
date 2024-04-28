/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The stored data for the app.
*/

import SwiftUI

/// The data that the app uses to configure its views.
@Observable
class ViewModel {
    
    // MARK: - Navigation
    var navigationPath: [Module] = []
    var titleText: String = ""
    var isTitleFinished: Bool = false
    var finalTitle: String = "Hello World"
    var seatNum: String = "01"

    // MARK: - Globe
    var isShowingGlobe: Bool = false
    
    var isGlobeRotating: Bool = false
    

    // MARK: - Orbit
    var isShowingOrbit: Bool = false
    

    // MARK: - Solar System
    var isShowingSolar: Bool = false
    

    var solarSunDistance: Double = 700
    
}
