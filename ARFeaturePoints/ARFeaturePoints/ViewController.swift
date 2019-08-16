//
//  ViewController.swift
//  ARFeaturePoints
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
        arView.debugOptions = .showFeaturePoints
    }
}
