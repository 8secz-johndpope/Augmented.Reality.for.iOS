//
//  ViewController.swift
//  ARRealityKit
//
//  Created by Jean Paul Marinho on 18/07/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let anchor = AnchorEntity(plane: .horizontal)
        arView.scene.addAnchor(anchor)
        let robot = try! ModelEntity.load(named: "robot")
        anchor.addChild(robot)
    }
}
