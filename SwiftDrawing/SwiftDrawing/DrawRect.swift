//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawRect: NSView {
    
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

    }
}
