//
//  CloudField.swift
//  World
//
//  Created by MAC  on 23/04/2024.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import _RealityKit_SwiftUI

struct CloudField: View {
    var body: some View {
        RealityView { content in
            let skybox = createSkybox()
            content.add(skybox!)
            
        }
    }
    
    private func createSkybox () -> Entity? {
        let largeSphere = MeshResource.generateSphere(radius: 180)
        var skyboxMaterial = UnlitMaterial ()
        
        do {
            let texture = try TextureResource.load(named: "bluesky")
            skyboxMaterial.color = .init(texture: .init(texture))
        } catch {
            print("Failed to create skybox material: \(error)")
            return nil
        }
        
        let skyboxEntity = Entity()
        
        skyboxEntity.components.set(ModelComponent (mesh:largeSphere, materials: [skyboxMaterial]))
        
        skyboxEntity.scale = .init(x: -1, y: 1, z: 1)
        return skyboxEntity
    }
}

#Preview {
    CloudField()
}
