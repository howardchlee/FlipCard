//
//  ViewController.swift
//  FlipCard
//
//  Created by Howard Lee on 7/3/16.
//  Copyright © 2016 Howard Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let container = CATransformLayer()
    let card = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.layer.addSublayer(container)
        container.addSublayer(card)
        card.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        card.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 100, height: 100), cornerRadius: 10).CGPath
        card.fillColor = UIColor.greenColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func flip(sender: AnyObject) {
        var t = CATransform3DIdentity
        t.m34 = -1.0/500.0
        let t90 = CATransform3DRotate(t, 90.0 * CGFloat(M_PI) / 180.0, 1, 0, 0)
        let t180 = CATransform3DRotate(t, 180.0 * CGFloat(M_PI) / 180.0, 1, 0, 0)
        UIView.animateKeyframesWithDuration(2, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: 0), animations: { 
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.5, animations: { 
                self.card.transform = t90
            })
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0, animations: {
                self.card.fillColor = UIColor.redColor().CGColor
            })
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5, animations: { 
                self.card.transform = t180
            })
            }) { (_) in
                
        }
        
        
    }
}

