//
//  CanvasViewController.swift
//  Canvas
//
//  Created by VietCas on 3/30/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    @IBOutlet weak var trayView: UIView!
    
    var startPoint: CGPoint!
    var trayOriginCenter: CGPoint!
    var imageViewOriginCenter: CGPoint!
    
    var trayCenterWhenOpen:CGPoint!
    var trayCenterWhenClose:CGPoint!
    
    var initPosY:CGFloat!
    
    var newlyCreatedFace: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        trayCenterWhenOpen = CGPoint(x: 0, y: self.view.frame.height - trayView.frame.height)
        trayCenterWhenClose = CGPoint(x:0, y: self.view.frame.height - 30)
        
        initPosY = self.view.frame.height - 30
        
        trayView.frame.origin.y = initPosY
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDragTrayView(panGestureRecognizer: UIPanGestureRecognizer) {
        let point = panGestureRecognizer.locationInView(view)
        
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            startPoint = point
            trayOriginCenter = trayView.center
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
             let translation = panGestureRecognizer.translationInView(trayView)
            trayView.center = CGPoint(x: trayOriginCenter.x, y: translation.y + trayOriginCenter.y)
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
            
            //let translation = panGestureRecognizer.translationInView(trayView)
            let velocity = panGestureRecognizer.velocityInView(view)
            
            //close 0 -> n
            if velocity.y > 0 {
                
                UIView.animateWithDuration(0.3, animations: {
                    self.trayView.frame.origin.y = self.trayCenterWhenClose.y
                })
                
            } else {
                
                UIView.animateWithDuration(0.3, animations: {
                    self.trayView.frame.origin.y = self.trayCenterWhenOpen.y
                })
            }
        }
    }
    
    
    @IBAction func onFacePan(panGestureRecognizer: UIPanGestureRecognizer) {
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            
            let imageView = panGestureRecognizer.view as! UIImageView
            
            imageViewOriginCenter = CGPoint(x: imageView.center.x, y: trayView.frame.origin.y + imageView.center.y)
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageViewOriginCenter
        
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            let translation = panGestureRecognizer.translationInView(newlyCreatedFace)
            newlyCreatedFace.center = CGPoint(x: imageViewOriginCenter.x + translation.x, y: imageViewOriginCenter.y + translation.y)
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onPanNewFace:")
            
            newlyCreatedFace.userInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
        }
        
    }
    
    var newfaceOriginCenter: CGPoint!
    var newImage: UIImageView!
    
    func onPanNewFace(panGestureRecognizer: UIPanGestureRecognizer) {
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            newImage = panGestureRecognizer.view as! UIImageView
            
            newfaceOriginCenter = CGPoint(x: newImage.center.x, y: newImage.center.y)
            newImage.transform = CGAffineTransformMakeScale(2, 2)
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            let translation = panGestureRecognizer.translationInView(newImage)
            newImage.center = CGPoint(x: newfaceOriginCenter.x + translation.x, y: newfaceOriginCenter.y + translation.y)
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            newImage.transform = CGAffineTransformMakeScale(1, 1)
            
        }
    }
    

}






