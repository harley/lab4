//
//  CanvasViewController.swift
//  lab4
//
//  Created by Dave Vo on 9/15/15.
//  Copyright (c) 2015 cheetah. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    
    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var downY: CGFloat!
    var upY: CGFloat!
    
    var initialNewFaceCenter: CGPoint!
    
    @IBOutlet weak var happyView: UIImageView!
    
    var newlyCreatedFace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        downY = 635
        upY   = 460
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        var velocity = sender.velocityInView(view)
        var state = sender.state
        
        var translation = sender.translationInView(self.view)
        
        if state == UIGestureRecognizerState.Began {
            trayOriginalCenter = trayView.center
        }
        
        if state == UIGestureRecognizerState.Changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }
        
        if state == UIGestureRecognizerState.Ended {
            if velocity.y > 0 {
                // close the tray
                trayView.center = CGPoint(x: trayOriginalCenter.x, y: downY)
            } else {
                UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options: nil, animations: { () -> Void in
                    self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.upY)
                }, completion: { (bool) -> Void in
                    println("animated: \(bool)")
                })
                // open the tray
                
                
            }
            
            
        }
    }
    
    
    @IBAction func onFacePan(sender: UIPanGestureRecognizer) {
        
        var state = sender.state
        var translation = sender.translationInView(self.view)
        
        var faceView = sender.view as! UIImageView
        
        newlyCreatedFace = UIImageView(image: faceView.image)
        newlyCreatedFace.userInteractionEnabled = true
        
        if state == UIGestureRecognizerState.Began {
            
            
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = faceView.center
            
            newlyCreatedFace.center.y += trayView.frame.origin.y
//            newlyCreatedFace.center.y += 100
            
            initialNewFaceCenter = newlyCreatedFace.center
            
            println("new x: \(newlyCreatedFace.center.x)")
            println("new y: \(newlyCreatedFace.center.y)")
        }
        
        if state == UIGestureRecognizerState.Changed {
            println("before new x: \(newlyCreatedFace.center.x)")
            println("before new y: \(newlyCreatedFace.center.y)")
            
            newlyCreatedFace.center.x = initialNewFaceCenter.x + translation.x
            newlyCreatedFace.center.y = initialNewFaceCenter.y + translation.y
            
            initialNewFaceCenter = newlyCreatedFace.center
            println("after new x: \(newlyCreatedFace.center.x)")
            println("after new y: \(newlyCreatedFace.center.y)")
            
            sender.setTranslation(CGPointZero, inView: self.view)
        }
        
    }
    
    
    
    
    
}
