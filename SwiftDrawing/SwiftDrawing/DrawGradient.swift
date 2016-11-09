//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawGradient: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let c = NSGraphicsContext.current()?.cgContext else { assertionFailure(); return }
        
        NSColor.yellow.setFill()
        c.fill(self.bounds)

        let r = CGRect(x: 20, y: 20, width: 300, height: 200)
        c.setFillColor(NSColor.cyan.cgColor)
        c.setStrokeColor(NSColor.black.cgColor)
        c.stroke(r)
        
        c.clip(to: r)
        
        let colors = [NSColor.white.cgColor, NSColor.blue.cgColor] as CFArray
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                  colors: colors,
                                  locations: nil)!

        c.drawLinearGradient(gradient,
                             start: CGPoint(x: 20, y: 190),
                             end: CGPoint(x: 320, y: 190),
                             options: [])
    }
}
