//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawLayers: NSView {
    
    override public init(frame frameRect: NSRect) {
        super.init(frame:frameRect)
        self.wantsLayer = true
    }
    
    override func updateLayer() {
        Swift.print("updateLayer")
        self.layer!.backgroundColor = NSColor.yellow.cgColor
        
        let l = CALayer()
        l.frame = CGRect(x: 50, y: 50, width: 200, height: 100)
        l.backgroundColor = NSColor.red.cgColor
        l.borderWidth = 5
        l.borderColor = NSColor.black.cgColor
        l.cornerRadius = 20.0
        l.name = "myLayer"
        self.layer!.addSublayer(l)
        
        let a1 = CABasicAnimation(keyPath: "transform.scale")
        a1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        a1.fromValue = 0.70
        a1.toValue = 1.30
        
        let a2 = CABasicAnimation(keyPath: "position")
        a2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        a2.fromValue = NSValue(point:CGPoint(x: 100, y: 100))
        a2.toValue = NSValue(point:CGPoint(x: 250, y: 250))
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [a1, a2]
        animationGroup.duration = 0.75
        animationGroup.isRemovedOnCompletion = false
        animationGroup.repeatCount = 1000
        animationGroup.autoreverses = true
        
        l.add(animationGroup, forKey: "xxx")
    }
    
    override func mouseDown(with event: NSEvent) {
        
        let p = self.convert(event.locationInWindow, from: nil)
        
        guard let hitLayer = self.layer!.presentation()!.hitTest(p), hitLayer.name == "myLayer" else { return }
        Swift.print("hit")
        
        let a = CABasicAnimation(keyPath: "backgroundColor")
        a.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        a.fromValue = NSColor.white.cgColor
        a.toValue = NSColor.red.cgColor
        hitLayer.add(a, forKey: "yyy")
    }
    
    required public init?(coder: NSCoder) {
        return nil
    }
}
