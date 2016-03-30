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
    let translation = sender.translationInView(self.view)

    let state    = sender.state

    if state == UIGestureRecognizerState.Began {
      trayOriginalCenter = trayView.center
    }
    
    if state == UIGestureRecognizerState.Changed {
      trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
    }
    
    if state == UIGestureRecognizerState.Ended {
      if velocity.y > 0 {
        // close tray
        trayView.center = CGPoint(x: trayOriginalCenter.x, y: downY)
      } else {
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [],
          animations: { () -> Void in
            // open tray
            self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.upY)
          }, completion: nil)
      }
    }
  }
  
  
  @IBAction func onFacePan(sender: UIPanGestureRecognizer) {
    let state = sender.state
    let translation = sender.translationInView(self.view)
    let faceView = sender.view as! UIImageView
    
    if state == UIGestureRecognizerState.Began {
      // copy to a new face
      newlyCreatedFace = UIImageView(image: faceView.image)
      newlyCreatedFace.userInteractionEnabled = true

      // add face to view
      view.addSubview(newlyCreatedFace)

      // set position for the new face
      let trayOrigin = trayView.frame.origin
      newlyCreatedFace.frame.origin.y = faceView.frame.origin.y + trayOrigin.y
      newlyCreatedFace.frame.origin.x = faceView.frame.origin.x + trayOrigin.x

      // remember this original position of new face
      initialNewFaceCenter = newlyCreatedFace.center
    } else if state == UIGestureRecognizerState.Changed {
      // set face to follow the pan
      newlyCreatedFace.center.x = initialNewFaceCenter.x + translation.x
      newlyCreatedFace.center.y = initialNewFaceCenter.y + translation.y
    }
  }
}
