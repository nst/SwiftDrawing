//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawImage: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let c = NSGraphicsContext.current()?.cgContext else { assertionFailure(); return }
        
        NSColor.yellow.setFill()
        c.fill(self.bounds)

        let r = CGRect(x: 20, y: 20, width: 300, height: 200)
        c.setStrokeColor(NSColor.black.cgColor)
        
        c.clip(to: r)
        
        let image = NSImage(named: "Lenna.png")!
        
        image.draw(in: CGRect(x: -30, y:-50, width:image.size.width, height:image.size.height))
        
        c.stroke(r)
    }
}
