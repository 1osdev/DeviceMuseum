//
//  ModelView.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 4.05.22.
//

import SwiftUI
import SceneKit

struct ModelView: UIViewRepresentable {
    let device: Device
    let scene : SCNScene
    
    init(device: Device) {
        self.device = device
        guard let url = Bundle.main.url(forResource:
                                            device.imageName, withExtension: "usdz") else { fatalError() }
        print("DEBUG: made scene with \(device.name) from file \(device.imageName).usdz")
        self.scene = try! SCNScene(url: url)
        addAnimation(node: self.scene.rootNode)
        }
    
    func addAnimation(node: SCNNode) {
        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 15.0)
        let repeatForever = SCNAction.repeatForever(rotateOne)
        node.runAction(repeatForever)
    }
    
    func makeUIView(context: Context) -> SCNView {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        cameraNode.position = SCNVector3(
            x: device.cameraPositionXYZ[0],
            y: device.cameraPositionXYZ[1],
            z: device.cameraPositionXYZ[2]
        )
    
        scene.rootNode.addChildNode(cameraNode)
        
        let lampLight = SCNNode()
        lampLight.light = SCNLight()
        lampLight.light?.type = .directional
        scene.rootNode.addChildNode(lampLight)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.white
        scene.rootNode.addChildNode(ambientLightNode)
    
        let sceneView = SCNView()
        sceneView.scene = scene
        return sceneView
    }
    
    func updateUIView(_ sceneView: SCNView, context: Context) {
        sceneView.scene = scene
        
        sceneView.cameraControlConfiguration.allowsTranslation = false
        
        sceneView.allowsCameraControl = true
    
        sceneView.showsStatistics = false
        
        sceneView.backgroundColor = UIColor.black
    }
}
        
struct ModelView_Previews: PreviewProvider {
    static var previews: some View {
        ModelView(device: deviceData[8])
    }
}
