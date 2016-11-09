//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawCompositionBlending: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let c = NSGraphicsContext.current()?.cgContext else { assertionFailure(); return }
        
        NSColor.yellow.setFill()
        c.fill(self.bounds)

        // cyan rect
        let r1 = CGRect(x: 20, y: 20, width: 300, height: 200)
        c.setFillColor(NSColor.cyan.cgColor)
        c.setStrokeColor(NSColor.black.cgColor)
        c.fill(r1)
        c.stroke(r1)
        
        // red circle
        let r2 = CGRect(x: 180, y: 100, width: 200, height: 200)
        c.setFillColor(NSColor.red.cgColor)
        
        c.setStrokeColor(NSColor.black.cgColor)
        c.setLineWidth(5.0)
        c.setBlendMode(.multiply)
        c.fillEllipse(in: r2)
        c.strokeEllipse(in: r2)
    }
}
