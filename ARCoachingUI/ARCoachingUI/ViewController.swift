//
//  ViewController.swift
//  ARCoachingUI
//
//  Created by Jean Paul Marinho on 18/07/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit
import ARKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    let coachingOverlay = ARCoachingOverlayView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let anchor = AnchorEntity(plane: .horizontal)
        arView.scene.addAnchor(anchor)
        let robot = try! ModelEntity.load(named: "robot")
        anchor.addChild(robot)
        
        setupCoachingOverlay()
    }
    
    func setupCoachingOverlay() {
        coachingOverlay.session = arView.session
        coachingOverlay.delegate = self
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.goal = .horizontalPlane
        setupCoachingOverlayView()
    }
    
    func setupCoachingOverlayView() {
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(coachingOverlay)
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}



extension ViewController: ARCoachingOverlayViewDelegate {
    
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        print("Will Activate")
    }
    
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        print("Did Deactivate")
    }
    
    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
        print("Did Request Session Reset")
    }
}
