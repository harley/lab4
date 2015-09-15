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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        
        
        
        var state = sender.state
        var translation = sender.translationInView(self.view)
        
        if state == UIGestureRecognizerState.Began {
            trayOriginalCenter = trayView.center
        }
        
        if state == UIGestureRecognizerState.Changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }
    }
    
    
    
    
}
