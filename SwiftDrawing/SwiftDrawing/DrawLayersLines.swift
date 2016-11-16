//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawLayersLines: NSView {
    
    override public init(frame frameRect: NSRect) {
        super.init(frame:frameRect)
        self.wantsLayer = true
    }
    
    override func updateLayer() {
        Swift.print("updateLayer")
        self.layer!.backgroundColor = NSColor.yellow.cgColor
        
        var points : [(Int,Int)] = []
        
        for _ in 0..<10 {
            let x = Int(arc4random_uniform(UInt32(self.frame.size.width-1.0)))
            let y = Int(arc4random_uniform(UInt32(self.frame.size.height-1.0)))
            points.append((x,y))
        }
        
        for (x,y) in points {
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: x, y: y))
            
            let sl = CAShapeLayer()
            sl.path = path
            sl.lineCap = "round"
            sl.lineWidth = 5
            sl.strokeColor = NSColor.red.cgColor
            self.layer!.addSublayer(sl)
            
            let a = CABasicAnimation(keyPath: "strokeEnd")
            a.duration = 1
            a.fromValue = 0.0
            a.toValue = 1.0
            sl.add(a, forKey: "xxx")
        }
    }
    
    required public init?(coder: NSCoder) {
        return nil
    }
}
