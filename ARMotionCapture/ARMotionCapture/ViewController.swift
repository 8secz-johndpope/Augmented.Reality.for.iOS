//
//  ViewController.swift
//  ARMotionCapture
//
//  Created by Jean Paul Marinho on 18/07/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit
import RealityKit
import ARKit
import Combine


class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    let characterAnchor = AnchorEntity(.body)

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard ARBodyTrackingConfiguration.isSupported else { return }
        let configuration = ARBodyTrackingConfiguration()
        arView.session.run(configuration)
        arView.scene.addAnchor(characterAnchor)

        var cancellable: AnyCancellable? = nil
        cancellable = Entity.loadBodyTrackedAsync(named: "character/robot").sink(
            receiveCompletion: { completion in },
            receiveValue: { (character) in
                character.scale = [1.0, 1.0, 1.0]
                self.characterAnchor.addChild(character)
                cancellable?.cancel()
        })
    }
}
