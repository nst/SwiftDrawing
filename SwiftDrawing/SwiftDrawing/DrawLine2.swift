//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawLine2: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let c = NSGraphicsContext.current()?.cgContext else { assertionFailure(); return }
        
        NSColor.yellow.setFill()
        c.fill(self.bounds)

        let p1 = NSPoint(x: 100, y: 100)
        let p2 = NSPoint(x: 300, y: 250)
        
        // dashed line
        let path = NSBezierPath()
        path.lineWidth = 5.0
        path.move(to: p1)
        path.line(to: p2)
        path.setLineDash([10.0, 10.0], count: 2, phase: 0.0)
        path.stroke()
        
        // begin / end dots
        c.setFillColor(NSColor.red.cgColor)
        for p in [p1, p2] {
            let r = CGRect(x: p.x-4, y: p.y-4, width: 9, height: 9)
            c.fillEllipse(in: r)
        }
        
        let font = NSFont.systemFont(ofSize: 24.0)
        let attr = [NSFontAttributeName:font]
        
        for p in [p1, p2] {
            let s = "\(Int(p.x), Int(p.y))"
            let yOffset : CGFloat = p.y > 160 ? 15 : -30
            let r = CGRect(x:p.x-60, y:p.y+yOffset, width:120, height:30)
            s.draw(with: r, options: [], attributes:attr, context:nil)
        }
    }
}
