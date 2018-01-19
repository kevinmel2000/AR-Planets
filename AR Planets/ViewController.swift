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
        
        createPlanets()
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
    
    func createPlanets() {
        
        let sunObject = SCNSphere(radius: 5)
        let moonObject = SCNSphere(radius: 0.2)
        let earthObject = SCNSphere(radius: 1)
        
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
        
        sunNode.position = SCNVector3(x: 0, y: 0, z: -30)
        moonNode.position = SCNVector3(x: 11.5, y: 0, z: -30)
        earthNode.position = SCNVector3(x: 10, y: 0, z: -30)
        
        sunNode.geometry = sunObject
        moonNode.geometry = moonObject
        earthNode.geometry = earthObject
        
        sceneView.scene.rootNode.addChildNode(sunNode)
        sceneView.scene.rootNode.addChildNode(moonNode)
        sceneView.scene.rootNode.addChildNode(earthNode)
        
        sceneView.autoenablesDefaultLighting = true
    }
}
