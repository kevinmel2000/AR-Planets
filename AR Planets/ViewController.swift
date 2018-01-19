//
//  ViewController.swift
//  AR Planets
//
//  Created by R. Kukuh on 19/01/18.
//  Copyright © 2018 R. Kukuh. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        //createPlanets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate Delegate Methods
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        
        let planNode = createPlane(with: planeAnchor)
        
        node.addChildNode(planNode)
    }
    
    // MARK: - Helpers
    
    func createPlane(with planeAnchor : ARPlaneAnchor) -> SCNNode {
        
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        let planNode = SCNNode()
        
        planNode.position  = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
        planNode.transform = SCNMatrix4MakeRotation(-(Float.pi/2), 1, 0, 0)
        
        let gridMaterial = SCNMaterial()
        
        gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
        
        plane.materials = [gridMaterial]
        
        planNode.geometry = plane
        
        return planNode
    }
    
    func createPlanets() {
        
        let sunObject = SCNSphere(radius: 0.9)
        let moonObject = SCNSphere(radius: 0.1)
        let earthObject = SCNSphere(radius: 0.2)
        
        let sunMaterial = SCNMaterial()
        let moonMaterial = SCNMaterial()
        let earthMaterial = SCNMaterial()
        
        sunMaterial.diffuse.contents = UIImage(named: "art.scnassets/2k/sun.jpg")
        moonMaterial.diffuse.contents = UIImage(named: "art.scnassets/2k/moon.jpg")
        earthMaterial.diffuse.contents = UIImage(named: "art.scnassets/2k/earth.jpg")
        
        sunObject.materials = [sunMaterial]
        moonObject.materials = [moonMaterial]
        earthObject.materials = [earthMaterial]
        
        let sunNode = SCNNode()
        let moonNode = SCNNode()
        let earthNode = SCNNode()
        
        sunNode.position = SCNVector3(x: 0, y: 0, z: -2)
        earthNode.position = SCNVector3(x: 0.5, y: 0.4, z: -1)
        moonNode.position = SCNVector3(x: 0.6, y: 0.3, z: -0.5)
        
        sunNode.geometry = sunObject
        moonNode.geometry = moonObject
        earthNode.geometry = earthObject
        
        sceneView.scene.rootNode.addChildNode(sunNode)
        sceneView.scene.rootNode.addChildNode(moonNode)
        sceneView.scene.rootNode.addChildNode(earthNode)
        
        sceneView.autoenablesDefaultLighting = true
    }
}
