//
//  FlipCard.swift
//  FlipCard
//
//  Created by Howard Lee on 7/3/16.
//  Copyright © 2016 Howard Lee. All rights reserved.
//

import UIKit

@IBDesignable
class FlipCard: UIView {
    
    @IBInspectable
    var frontImage: UIImage? = UIImage(named: "elephant") {
        didSet {
            if open {
                imageLayer.contents = frontImage?.CGImage
                setNeedsDisplay()
            }
        }
    }

    @IBInspectable
    var backImage: UIImage? = UIImage(named: "leopard") {
        didSet {
            if !open {
                imageLayer.contents = backImage?.CGImage
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable
    var open: Bool = false {
        didSet {
            if open {
                imageLayer.contents = frontImage?.CGImage
            } else {
                imageLayer.contents = backImage?.CGImage
            }
            setNeedsDisplay()
        }
    }
    
    private var imageLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        layer.addSublayer(imageLayer)
        imageLayer.contents = backImage?.CGImage
        setOpen(false, animated: false)
        let tapGR = UITapGestureRecognizer.init(target: self, action: #selector(didTap(_:)))
        addGestureRecognizer(tapGR)
    }
    
    override func layoutSubviews() {
        imageLayer.frame = bounds
    }
    
    func setOpen(open: Bool, animated: Bool) {
        var finalTransform = CATransform3DIdentity
        finalTransform.m34 = -1/500
        let halfTransform = CATransform3DRotate(finalTransform, CGFloat(M_PI)/2, 0, 1, 0)
        if open {
            finalTransform = CATransform3DRotate(finalTransform, CGFloat(M_PI), 0, 1, 0)
        }
        if animated {
            UIView.animateKeyframesWithDuration(2, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: 0), animations: {
                UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.5, animations: {
                    self.imageLayer.transform = halfTransform
                })
                UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0, animations: {
                    self.open = open
                })
                UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5, animations: {
                    self.imageLayer.transform = finalTransform
                })
            }, completion: nil)
        } else {
            self.imageLayer.transform = finalTransform
        }
    }
    
    func didTap(tapGR: UITapGestureRecognizer) {
        setOpen(!open, animated: true)
    }
}
