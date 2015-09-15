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
    var animator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animator = UIDynamicAnimator(referenceView: view)
        
        var gravityBehavior = UIGravityBehavior(items: [trayView])
        animator.addBehavior(gravityBehavior)
        
        var collisionBehavior = UICollisionBehavior(items: [trayView])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBehavior)

        downY = 635
        upY   = 460
        // Do any additional setup after loading the view.
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
//                self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.upY)
//                var elasticityBehavior = UIDynamicItemBehavior(items: [trayView])
//                elasticityBehavior.elasticity = 0.7
//                animator.addBehavior(elasticityBehavior)


                UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options: nil, animations: { () -> Void in
                    self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.upY)
                }, completion: { (bool) -> Void in
                    println("animated: \(bool)")
                })
                // open the tray
                
                
            }
            
            
        }
    }
    
    
    
    
}
