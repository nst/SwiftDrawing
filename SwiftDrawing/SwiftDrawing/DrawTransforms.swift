//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawTransforms: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let c = NSGraphicsContext.current()?.cgContext else { assertionFailure(); return }
        
        NSColor.yellow.setFill()
        c.fill(self.bounds)
        
        let r = CGRect(x: 0, y: 0, width: 250, height: 120)

        c.setFillColor(NSColor.red.cgColor)
        
        let colors = [NSColor.cyan, NSColor.magenta, NSColor.red, NSColor.purple]
        
        for i in 0...3 {
            c.saveGState()
            
            let t = NSAffineTransform()
            t.translateX(by: 200.0 - CGFloat(i)*30.0, yBy: 100 - 10*CGFloat(i))
            t.rotate(byDegrees: 60.0 - 15*CGFloat(i))
            t.concat()
            
            c.setFillColor(colors[i].cgColor)
            c.fill(r)
            c.stroke(r)
            
            c.restoreGState()
        }
    }
}
