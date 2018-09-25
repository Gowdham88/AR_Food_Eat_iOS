//
//  ViewController.swift
//  Food & Eat
//
//  Created by Paramesh V on 20/09/18.
//  Copyright © 2018 Paramesh V. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
   
    // UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate

    @IBOutlet var sceneView: ARSCNView!
    var collectionView: UICollectionView!
    
    let configuration = ARImageTrackingConfiguration()
    let augmentedRealitySession = ARSession()
    var targetAnchor: ARImageAnchor?
    var headingView: UIView?
    
    
    let fadeDuration: TimeInterval = 0.3
    let rotateDuration: TimeInterval = 3
    let waitDuration: TimeInterval = 0.5
    
    lazy var fadeAndSpinAction: SCNAction = {
        return .sequence([
            .fadeIn(duration: fadeDuration),
            .rotateBy(x: 0, y: 0, z: CGFloat.pi * 360 / 180, duration: rotateDuration),
            .wait(duration: waitDuration),
            .fadeOut(duration: fadeDuration)
            ])
    }()
    
    lazy var fadeAction: SCNAction = {
        return .sequence([
            .fadeOpacity(by: 0.8, duration: fadeDuration),
            .wait(duration: waitDuration),
            .fadeOut(duration: fadeDuration)
            ])
    }()
    
    lazy var treeNode: SCNNode = {
        guard let scene = SCNScene(named: "art.scnassets/ship.scn"),
            let node = scene.rootNode.childNode(withName: "ship", recursively: false) else { return SCNNode() }
        let scaleFactor = 0.0002
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        node.position = SCNVector3(-0.035, 0, 0)
        node.eulerAngles.x = .pi / 2
        node.eulerAngles.y = .pi / 2
        node.eulerAngles.z = .pi / 2
        

        return node
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.autoenablesDefaultLighting = true
        let ARScene = SCNScene()
        sceneView.scene = ARScene
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupARSession()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func setupARSession(){
        
        //1. Setup Our Tracking Images
        guard let trackingImages =  ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        configuration.trackingImages = trackingImages
        configuration.maximumNumberOfTrackedImages = 1
        
        //2. Configure & Run Our ARSession
        sceneView.session = augmentedRealitySession
        augmentedRealitySession.delegate = self
        sceneView.delegate = self
        augmentedRealitySession.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }//setupARSession
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let anchorNode = SCNNode()
        anchorNode.name = "anchor"
        sceneView.scene.rootNode.addChildNode(anchorNode)
        return anchorNode
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
//        var modelNode = SCNNode?
        DispatchQueue.main.async {
            guard let imageAnchor = anchor as? ARImageAnchor,
                let imageName = imageAnchor.referenceImage.name else { return }
 
            
//            self.label.text = "Image detected: \"\(imageName)\""
        
        
//        guard let imageAnchor = anchor as? ARImageAnchor else {return}
//
//        if let imageName  = imageAnchor.referenceImage.name {
//
//            print(imageName)
//
//
//            if imageName == "Oyster1"{
            _ = CGFloat(GLKMathDegreesToRadians(360))

        
                // Check To See The Detected Size Of Our Oyster1 Card (Should By 18cm*27cm)
                let Oyster1CardWidth = imageAnchor.referenceImage.physicalSize.width
                let Oyster1CardHeight =  imageAnchor.referenceImage.physicalSize.height
                
                print(
                    """
                    We Have Detected Oyster1 Card With Name \(imageName)
                    \(imageName)'s Width Is \(Oyster1CardWidth)
                    \(imageName)'s Height Is \(Oyster1CardHeight)
                    """)
                
                let plane = SCNPlane(width: Oyster1CardWidth, height: Oyster1CardHeight)
                plane.firstMaterial?.diffuse.contents = UIColor.black.withAlphaComponent(0.75)
                
                let planeNode = SCNNode(geometry: plane)
                planeNode.eulerAngles.x = -.pi / 2
                planeNode.runAction(SCNAction.moveBy(x:  -1.0, y: 0, z: 0, duration: 0))
                
 
                // TODO: Overlay 3D Object
                let overlayNode = self.getNode(withImageName: imageName)
                print("overlay::\(overlayNode)")
                overlayNode.position = SCNVector3(-0.035, 0, 0)
                node.addChildNode(overlayNode)
            
            
            
            
            
                /******************Break fast*******************/
                
                //BREAKFAST, FALTBREADS, SANDWICHES, ALLDAY
                let labelPlane = SCNPlane(width: 0.065, height: 0.015)
                labelPlane.firstMaterial?.diffuse.contents = UIImage(named: "BREAKFAST")
               
                let lableNode = SCNNode(geometry: labelPlane)
                lableNode.eulerAngles.x = -.pi / 2
                lableNode.runAction(SCNAction.moveBy(x: 0.2, y: 0, z: -0.125, duration: 0))
                //1
                //image left
                let b_image1Plane = SCNPlane(width: 0.045, height: 0.03)
                b_image1Plane.firstMaterial?.diffuse.contents = UIImage(named: "breakFast1")
                b_image1Plane.cornerRadius = 0.0025
                
                let b_imageNode = SCNNode(geometry: b_image1Plane)
                b_imageNode.eulerAngles.x = -.pi / 2
                b_imageNode.runAction(SCNAction.moveBy(x: 0.125, y: 0, z: -0.09, duration: 0))
                
                //item name1
                let b_labelPlane = SCNPlane(width: 0.035, height: 0.01)
                b_labelPlane.firstMaterial?.diffuse.contents = UIImage(named: "breakfast_text1")
                
                let b_lableNode = SCNNode(geometry: b_labelPlane)
                b_lableNode.eulerAngles.x = -.pi / 2
                b_lableNode.runAction(SCNAction.moveBy(x: 0.125, y: 0, z: -0.065, duration: 0))
                
                
                
                //2
                //image center
                let b_image1Plane_1 = SCNPlane(width: 0.045, height: 0.03)
                b_image1Plane_1.firstMaterial?.diffuse.contents = UIImage(named: "breakFast2")
                b_image1Plane_1.cornerRadius = 0.0025

                
                let b_imageNode_1 = SCNNode(geometry: b_image1Plane_1)
                b_imageNode_1.eulerAngles.x = -.pi / 2
                b_imageNode_1.runAction(SCNAction.moveBy(x: 0.2, y: 0, z: -0.09, duration: 0))
                //item name2
                let b_labelPlane1 = SCNPlane(width: 0.035, height: 0.01)
                b_labelPlane1.firstMaterial?.diffuse.contents = UIImage(named: "breakfast_text2")
                
                let b_lableNode1 = SCNNode(geometry: b_labelPlane1)
                b_lableNode1.eulerAngles.x = -.pi / 2
                b_lableNode1.runAction(SCNAction.moveBy(x: 0.2, y: 0, z: -0.065, duration: 0))
                
                
                //3
                //image right
                let b_image1Plane_2 = SCNPlane(width: 0.045, height: 0.03)
                b_image1Plane_2.firstMaterial?.diffuse.contents = UIImage(named: "breakFast3")
                b_image1Plane_2.cornerRadius = 0.0025

                
                let b_imageNode_2 = SCNNode(geometry: b_image1Plane_2)
                b_imageNode_2.eulerAngles.x = -.pi / 2
                b_imageNode_2.runAction(SCNAction.moveBy(x: 0.275, y: 0, z: -0.09, duration: 0))
                //item name3
                let b_labelPlane2 = SCNPlane(width: 0.035, height: 0.01)
                b_labelPlane2.firstMaterial?.diffuse.contents = UIImage(named: "breakfast_text3")
                
                let b_lableNode2 = SCNNode(geometry: b_labelPlane2)
                b_lableNode2.eulerAngles.x = -.pi / 2
                b_lableNode2.runAction(SCNAction.moveBy(x: 0.275, y: 0, z: -0.065, duration: 0))
            
                /******************All day dining*******************/
                let h_labelPlane = SCNPlane(width: 0.065, height: 0.015)
                h_labelPlane.firstMaterial?.diffuse.contents = UIImage(named: "ALLDAY")
                
                let h_lableNode = SCNNode(geometry: h_labelPlane)
                h_lableNode.eulerAngles.x = -.pi / 2
                h_lableNode.runAction(SCNAction.moveBy(x: 0.2, y: 0, z: -0.04, duration: 0))
                
                /******************Sandwiches*******************/
                
                let h_labelPlane1 = SCNPlane(width: 0.065, height: 0.015)
                h_labelPlane1.firstMaterial?.diffuse.contents = UIImage(named: "SANDWICHES")
                
                let h_lableNode1 = SCNNode(geometry: h_labelPlane1)
                h_lableNode1.eulerAngles.x = -.pi / 2
                h_lableNode1.runAction(SCNAction.moveBy(x: 0.125, y: 0, z: -0.02, duration: 0))
                
                //1
                //image left
                let s_image1Plane = SCNPlane(width: 0.045, height: 0.03)
                s_image1Plane.firstMaterial?.diffuse.contents = UIImage(named: "sandwich1")
                s_image1Plane.cornerRadius = 0.0025
                
                let s_imageNode = SCNNode(geometry: s_image1Plane)
                s_imageNode.eulerAngles.x = -.pi / 2
                s_imageNode.runAction(SCNAction.moveBy(x: 0.125, y: 0, z: 0.011, duration: 0))
                
                //item name1
                let s_labelPlane = SCNPlane(width: 0.035, height: 0.01)
                s_labelPlane.firstMaterial?.diffuse.contents = UIImage(named: "sandwich_text1")
                
                let s_lableNode = SCNNode(geometry: s_labelPlane)
                s_lableNode.eulerAngles.x = -.pi / 2
                s_lableNode.runAction(SCNAction.moveBy(x: 0.125, y: 0, z: 0.038, duration: 0))
                
                
                
                //2
                //image center
                let s_image1Plane_1 = SCNPlane(width: 0.045, height: 0.03)
                s_image1Plane_1.firstMaterial?.diffuse.contents = UIImage(named: "sandwich2")
                s_image1Plane_1.cornerRadius = 0.0025
                
                
                let s_imageNode_1 = SCNNode(geometry: s_image1Plane_1)
                s_imageNode_1.eulerAngles.x = -.pi / 2
                s_imageNode_1.runAction(SCNAction.moveBy(x: 0.2, y: 0, z: 0.011, duration: 0))
                //item name2
                let s_labelPlane1 = SCNPlane(width: 0.035, height: 0.01)
                s_labelPlane1.firstMaterial?.diffuse.contents = UIImage(named: "sandwich_text2")
                
                let s_lableNode1 = SCNNode(geometry: s_labelPlane1)
                s_lableNode1.eulerAngles.x = -.pi / 2
                s_lableNode1.runAction(SCNAction.moveBy(x: 0.2, y: 0, z: 0.038, duration: 0))
                
                
                //3
                //image right
                let s_image1Plane_2 = SCNPlane(width: 0.045, height: 0.03)
                s_image1Plane_2.firstMaterial?.diffuse.contents = UIImage(named: "sandwich3")
                s_image1Plane_2.cornerRadius = 0.0025
                
                
                let s_imageNode_2 = SCNNode(geometry: s_image1Plane_2)
                s_imageNode_2.eulerAngles.x = -.pi / 2
                s_imageNode_2.runAction(SCNAction.moveBy(x: 0.275, y: 0, z: 0.011, duration: 0))
                //item name3
                let s_labelPlane2 = SCNPlane(width: 0.035, height: 0.01)
                s_labelPlane2.firstMaterial?.diffuse.contents = UIImage(named: "sandwich_text3")
                
                let s_lableNode2 = SCNNode(geometry: s_labelPlane2)
                s_lableNode2.eulerAngles.x = -.pi / 2
                s_lableNode2.runAction(SCNAction.moveBy(x: 0.275, y: 0, z: 0.038, duration: 0))
                
                /******************Flatbreads*******************/
                let h_labelPlane2 = SCNPlane(width: 0.065, height: 0.015)
                h_labelPlane2.firstMaterial?.diffuse.contents = UIImage(named: "FALTBREADS")
                
                let h_lableNode2 = SCNNode(geometry: h_labelPlane2)
                h_lableNode2.eulerAngles.x = -.pi / 2
                h_lableNode2.runAction(SCNAction.moveBy(x: 0.125, y: 0, z: 0.06, duration: 0))
                

                //1
                //image left
                let f_image1Plane = SCNPlane(width: 0.045, height: 0.03)
                f_image1Plane.firstMaterial?.diffuse.contents = UIImage(named: "flatBreads1")
                f_image1Plane.cornerRadius = 0.0025
                
                let f_imageNode = SCNNode(geometry: f_image1Plane)
                f_imageNode.eulerAngles.x = -.pi / 2
                f_imageNode.runAction(SCNAction.moveBy(x: 0.125, y: 0, z: 0.09, duration: 0))
                
                //item name1
                let f_labelPlane = SCNPlane(width: 0.035, height: 0.01)
                f_labelPlane.firstMaterial?.diffuse.contents = UIImage(named: "flatbreads_text1")
                
                let f_lableNode = SCNNode(geometry: f_labelPlane)
                f_lableNode.eulerAngles.x = -.pi / 2
                f_lableNode.runAction(SCNAction.moveBy(x: 0.125, y: 0, z: 0.117, duration: 0))
                
                //2
                //image center
                let f_image1Plane_1 = SCNPlane(width: 0.045, height: 0.03)
                f_image1Plane_1.firstMaterial?.diffuse.contents = UIImage(named: "flatBreads2")
                f_image1Plane_1.cornerRadius = 0.0025
                
                
                let f_imageNode_1 = SCNNode(geometry: f_image1Plane_1)
                f_imageNode_1.eulerAngles.x = -.pi / 2
                f_imageNode_1.runAction(SCNAction.moveBy(x: 0.2, y: 0, z: 0.09, duration: 0))
                //item name2
                let f_labelPlane1 = SCNPlane(width: 0.035, height: 0.01)
                f_labelPlane1.firstMaterial?.diffuse.contents = UIImage(named: "flatbreads_text2")
                
                let f_lableNode1 = SCNNode(geometry: f_labelPlane1)
                f_lableNode1.eulerAngles.x = -.pi / 2
                f_lableNode1.runAction(SCNAction.moveBy(x: 0.2, y: 0, z: 0.117, duration: 0))
                
                
                //3
                //image right
                let f_image1Plane_2 = SCNPlane(width: 0.045, height: 0.03)
                f_image1Plane_2.firstMaterial?.diffuse.contents = UIImage(named: "flatBreads3")
                f_image1Plane_2.cornerRadius = 0.0025
                
                
                let f_imageNode_2 = SCNNode(geometry: f_image1Plane_2)
                f_imageNode_2.eulerAngles.x = -.pi / 2
                f_imageNode_2.runAction(SCNAction.moveBy(x: 0.275, y: 0, z: 0.09, duration: 0))
                //item name3
                let f_labelPlane2 = SCNPlane(width: 0.035, height: 0.01)
                f_labelPlane2.firstMaterial?.diffuse.contents = UIImage(named: "flatbreads_text3")
                
                let f_lableNode2 = SCNNode(geometry: f_labelPlane2)
                f_lableNode2.eulerAngles.x = -.pi / 2
                f_lableNode2.runAction(SCNAction.moveBy(x: 0.275, y: 0, z: 0.117, duration: 0))
                
                
                /********************************************************/
                
                node.addChildNode(overlayNode)
//                node.addChildNode(planeNode)
                //breakfast node
                node.addChildNode(lableNode)
                node.addChildNode(b_imageNode)
                node.addChildNode(b_imageNode_1)
                node.addChildNode(b_imageNode_2)
                node.addChildNode(b_lableNode)
                node.addChildNode(b_lableNode1)
                node.addChildNode(b_lableNode2)

                //All day node
                node.addChildNode(h_lableNode)
                
                //sandwinches node
                node.addChildNode(h_lableNode1)
                node.addChildNode(s_imageNode)
                node.addChildNode(s_imageNode_1)
                node.addChildNode(s_imageNode_2)
                node.addChildNode(s_lableNode)
                node.addChildNode(s_lableNode1)
                node.addChildNode(s_lableNode2)

                //flatbreads ndoe
                node.addChildNode(h_lableNode2)
                node.addChildNode(f_imageNode)
                node.addChildNode(f_imageNode_1)
                node.addChildNode(f_imageNode_2)
                node.addChildNode(f_lableNode)
                node.addChildNode(f_lableNode1)
                node.addChildNode(f_lableNode2)



                self.sceneView.scene.rootNode.addChildNode(node)
                
            }//imageName ends
            
//        }
        
    }//renderer
    
    func getNode(withImageName name: String) -> SCNNode {
        var node = SCNNode()
        switch name {
        case "Oyster1":
            node = treeNode
        default:
            break
        }
        return node
    }

    func addSceneToScene() {
        let geoScene = SCNScene(named: "art.scnassets/cake.dae")
        self.sceneView.scene.rootNode.addChildNode((geoScene?.rootNode.childNode(withName: "cake", recursively: true)!)!)
    }
    
    
    //collection view
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = UICollectionViewCell()
//
//        return cell
//
//    }
    
}//class
