//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawPushAndPop: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let c = NSGraphicsContext.current()?.cgContext else { assertionFailure(); return }
        
        NSColor.yellow.setFill()
        c.fill(self.bounds)

        let r1 = CGRect(x: 20, y: 70, width: 200, height: 150)
        let r2 = CGRect(x: 50, y: 110, width: 200, height: 150)
        let r3 = CGRect(x: 80, y: 150, width: 200, height: 150)
        let r4 = CGRect(x: 110, y: 190, width: 200, height: 150)

        c.setFillColor(NSColor.cyan.cgColor)
        
        c.fill(r1)
        c.stroke(r1)

        // save current context (fill cyan)
        c.saveGState()

        // change fill color to magenta
        c.setFillColor(NSColor.magenta.cgColor)

        c.fill(r2)
        c.stroke(r2)

        c.fill(r3)
        c.stroke(r3)

        // restore saved context (fill cyan)
        c.restoreGState()
        
        c.fill(r4)
        c.stroke(r4)

    }
}

