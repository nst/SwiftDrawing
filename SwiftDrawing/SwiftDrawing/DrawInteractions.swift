//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawInteractionsEllipse: NSView {

    var isHighlighted = false
    var fillColor : NSColor
    
    func strikeColor() -> NSColor {
        return isHighlighted ? NSColor.cyan : NSColor.black
    }
    
    public init(frame frameRect: NSRect, fillColor: NSColor) {
        self.fillColor = fillColor
        super.init(frame:frameRect)
    }
    
    required public init?(coder: NSCoder) {
        return nil
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let c = NSGraphicsContext.current()?.cgContext else { assertionFailure(); return }
        
        let b = self.bounds
        let r = CGRect(x: b.origin.x + 10, y: b.origin.y + 10, width: b.size.width - 20, height: b.height - 20)
        
        c.setFillColor(fillColor.cgColor)
        c.setStrokeColor(strikeColor().cgColor)
        c.setLineWidth(5.0)
        c.fillEllipse(in: r)
        c.strokeEllipse(in: r)
    }
    
    override func mouseDown(with event: NSEvent) {
        Swift.print("mouseDown")
        self.isHighlighted = true
        self.setNeedsDisplay(self.bounds)
    }

    override func mouseUp(with event: NSEvent) {
        Swift.print("mouseUp")
        self.isHighlighted = false
        self.setNeedsDisplay(self.bounds)
    }
    
    override func mouseDragged(with event: NSEvent) {
        //Swift.print("mouseDragged")
        let origin = self.frame.origin
        let pNew = CGPoint(x: origin.x + event.deltaX, y: origin.y - event.deltaY)
        self.setFrameOrigin(pNew)
        self.setNeedsDisplay(self.bounds)
    }
}

class DrawInteractions: NSView {
    
    override public init(frame frameRect: NSRect) {
        super.init(frame:frameRect)
        
        let r1 = CGRect(x: 180, y: 100, width: 100, height: 100)
        let r2 = CGRect(x: 250, y: 100, width: 80, height: 80)

        let ellipseView1 = DrawInteractionsEllipse(frame: r1, fillColor:NSColor.red)
        let ellipseView2 = DrawInteractionsEllipse(frame: r2, fillColor:NSColor.blue)

        self.addSubview(ellipseView1)
        self.addSubview(ellipseView2)
    }
    
    required public init?(coder: NSCoder) {
        return nil
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let c = NSGraphicsContext.current()?.cgContext else { return }
        
        NSColor.yellow.setFill()
        c.fill(self.bounds)
    }
}
