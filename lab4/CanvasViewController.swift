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
    
    view.userInteractionEnabled = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
    let velocity = sender.velocityInView(view)
    let state = sender.state
    
    let translation = sender.translationInView(self.view)
    
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
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options: [], animations: { () -> Void in
          self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.upY)
          }, completion: { (bool) -> Void in
            print("animated: \(bool)")
        })
      }
    }
  }
  
  
  @IBAction func onFacePan(sender: UIPanGestureRecognizer) {
    let state = sender.state
    let translation = sender.translationInView(self.view)
    let faceView = sender.view as! UIImageView
    
    if state == UIGestureRecognizerState.Began {
      newlyCreatedFace = UIImageView(image: faceView.image)
      newlyCreatedFace.userInteractionEnabled = true
      
      view.addSubview(newlyCreatedFace)
      newlyCreatedFace.center = faceView.center
      
      newlyCreatedFace.center.y += trayView.frame.origin.y
      initialNewFaceCenter = newlyCreatedFace.center
      
      print("new x: \(newlyCreatedFace.center.x)")
      print("new y: \(newlyCreatedFace.center.y)")
    }
    
    if state == UIGestureRecognizerState.Changed {
      newlyCreatedFace.center.x = initialNewFaceCenter.x + translation.x
      newlyCreatedFace.center.y = initialNewFaceCenter.y + translation.y
    }
  }
}
