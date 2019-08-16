//
//  ViewController.swift
//  NerdzaoAR
//
//  Created by Jean Paul Marinho on 11/08/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    let centerScreen = CGPoint(x: UIScreen.main.bounds.maxX / 2.0, y: UIScreen.main.bounds.maxY / 2.0)
    var node: SCNNode!
    var audioSource: SCNAudioSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        let scene = SCNScene(named: "art.scnassets/Main.scn")!
        sceneView.scene = scene
        
        if let audioSource = SCNAudioSource(fileNamed: "art.scnassets/battle.mp3") {
            audioSource.volume = 1
            audioSource.isPositional = false
            audioSource.load()
            self.audioSource = audioSource
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        self.node = self.sceneView.scene.rootNode.childNode(withName: "MewtwoMegaX", recursively: true)
        self.node.isHidden = true

    }
    
    func startHitTest() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            let hitTest = self.sceneView.hitTest(self.centerScreen, types: .estimatedHorizontalPlane)
            if let hitResult = hitTest.first {
                let scnMatrix = SCNMatrix4(hitResult.worldTransform)
                let position = SCNVector3Make(scnMatrix.m41, scnMatrix.m42, scnMatrix.m43)
                self.updateNode(position: position)
                timer.invalidate()
            }
        }
    }
    
    func updateNode(position: SCNVector3) {
        self.node.position = position
        self.node.isHidden = false
        self.node.addAudioPlayer(SCNAudioPlayer(source: self.audioSource))
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        
        switch camera.trackingState {
        case .normal:
            self.startHitTest()
        default:
            return
        }
    }
}
