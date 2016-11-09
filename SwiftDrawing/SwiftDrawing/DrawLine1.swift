//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawLine1: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let c = NSGraphicsContext.current()?.cgContext else { assertionFailure(); return }
        
        NSColor.yellow.setFill()
        c.fill(self.bounds)

        // simple line
        
        let p1 = NSPoint(x: 100, y: 100)
        let p2 = NSPoint(x: 300, y: 250)
        
        let path = NSBezierPath()
        path.move(to: p1)
        path.line(to: p2)
        path.stroke()
    }
}

// Drawing code here.

// macOS
//guard let c = NSGraphicsContext.current()?.cgContext else { assertionFailure(); return }
// iOS
//guard let c = UIGraphicsGetCurrentContext() else { assertionFailure(); return }

// programmatic drawing

// http://www.informit.com/articles/article.aspx?p=2149190&seqNum=12

