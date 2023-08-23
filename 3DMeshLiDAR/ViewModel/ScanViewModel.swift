//
//  ScanViewModel.swift
//  3DMeshLiDAR
//
//  Created by Mahesh on 22/08/23.
//

import UIKit
import RealityKit
import ARKit

class ScanViewModel: NSObject {
    var info: String {
        "Tap the below button to Export 3D mesh object (.obj file)"
    }
    func buildConfigure() -> ARWorldTrackingConfiguration {
        let configuration = ARWorldTrackingConfiguration()
        configuration.environmentTexturing = .automatic
        configuration.sceneReconstruction = .mesh
        if type(of: configuration).supportsFrameSemantics(.sceneDepth) {
            configuration.frameSemantics = .sceneDepth
        }
        return configuration
    }
    func convertToAsset(meshAnchors: [ARMeshAnchor], camera: ARCamera) -> MDLAsset? {
        guard let device = MTLCreateSystemDefaultDevice() else {return nil}
        let asset = MDLAsset()
        for anchor in meshAnchors {
            let mdlMesh = anchor.geometry.toMDLMesh(device: device, camera: camera, modelMatrix: anchor.transform)
            asset.add(mdlMesh)
        }
        return asset
    }
    func export(asset: MDLAsset) throws -> URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = directory.appendingPathComponent("scaned.obj")
        try asset.export(to: url)
        return url
    }
}
