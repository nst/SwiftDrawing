//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawClipping: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let c = NSGraphicsContext.current()?.cgContext else { assertionFailure(); return }
        
        NSColor.yellow.setFill()
        c.fill(self.bounds)

        // clipping
        
        let r1 = CGRect(origin: CGPoint(x:100, y:120), size: CGSize(width: 200, height: 200))
        c.setFillColor(NSColor.white.cgColor)
        c.fillEllipse(in: r1)
        c.strokeEllipse(in: r1)
        
        let path1 = NSBezierPath(ovalIn: r1)
        path1.addClip()
        
        let r2 = CGRect(origin: CGPoint(x:180, y:100), size: CGSize(width: 180, height: 200))
        c.setFillColor(NSColor.blue.cgColor)
        c.fillEllipse(in: r2)
        c.strokeEllipse(in: r2)
        
    }
}
