//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawPath: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let c = NSGraphicsContext.current()?.cgContext else { assertionFailure(); return }
        
        NSColor.yellow.setFill()
        c.fill(self.bounds)

        let p0 = CGPoint(x: 100, y: 50)
        let p1 = CGPoint(x: 250, y: 200)
        let cp1 = CGPoint(x: 50, y: 300)
        let cp2 = CGPoint(x: 300, y: 300)
        
        // custom path
        let path = NSBezierPath()
        path.move(to: p0)
        path.curve(to: p1, controlPoint1: cp1, controlPoint2: cp2)
        path.stroke()
        
        c.setLineWidth(5.0)
        for p in [p0, p1, cp1, cp2] {
            c.strokeEllipse(in: CGRect(origin: p, size: CGSize(width: 1, height: 1)))
        }
    }
}
