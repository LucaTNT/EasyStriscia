//
//  BezierViewController
//  Animazioni
//
//  Created by Andraghetti on 31/10/15.
//  Copyright © 2015 Lorenzo Andraghetti. All rights reserved.
//

import UIKit

class BezierViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var numberOfImagesSlider: UISlider!
    
    let imagesSet = [
        UIImage(named: "Fede.png"),
        UIImage(named: "Luca.png")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        
        loadBezier()
        
    }
    
    func loadBezier() {
        let size = 100
        for _ in 0...5 {
            let face = UIImageView()
            let imagesCount = UInt32.init(imagesSet.count)
            let rand = Int(arc4random_uniform(imagesCount))
            face.image = imagesSet[rand]
            face.frame = CGRect(x: size, y: size, width: size, height: size)
            self.view.addSubview(face)
            
            let randomYOffset = CGFloat( arc4random_uniform(250))
            
            // Bezier
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 0-randomYOffset,y: 300 + randomYOffset))
            path.addCurveToPoint(CGPoint(x: 400+CGFloat(size), y: 239 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 373 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 110 + randomYOffset))
            
            // create the animation
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.CGPath
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            anim.duration = Double(arc4random_uniform(40)+30) / 10
            anim.timeOffset = Double(arc4random_uniform(290))
            
            
            // add the animation
            face.layer.addAnimation(anim, forKey: "animate position along path")
        }

    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if (viewController == self) {
            for view in self.view.subviews {
                if view is UIImageView {
                    view.removeFromSuperview()
                }
            }
            loadBezier()
        }
    }
    
    @IBAction func animateButtonPressed(sender: AnyObject) {
        
        let numberOfImages = Int(self.numberOfImagesSlider.value) + 10
        // loop for 10 times
        for _ in 1...numberOfImages {
            
            // set up some constants for the animation
            let duration : NSTimeInterval = 5.0
            let delay = NSTimeInterval(arc4random_uniform(1000)) / 400
            let options = UIViewAnimationOptions.CurveLinear
            
            // set up some constants for the face
            let size : CGFloat = CGFloat( arc4random_uniform(80))+50
            let yPosition : CGFloat = CGFloat( arc4random_uniform(400))+20
            
            // create the face and add it to the screen
            let face = UIImageView()
            let imagesCount = UInt32.init(imagesSet.count)
            let rand = Int(arc4random_uniform(imagesCount))
            face.image = imagesSet[rand]
            face.frame = CGRectMake(-size, yPosition, size, size)
            self.view.addSubview(face)
            
            // define the animation
            UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
                
                // move the face
                face.frame = CGRectMake(320+size, yPosition, size, size)
                
                
                }, completion: { animationFinished in
                    
                    // remove the face
                    face.removeFromSuperview()
                    
            })
        }
    }
    
    func emptyView() {
        self.view.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        emptyView()
    }
}

