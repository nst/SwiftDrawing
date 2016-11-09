//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawText: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let c = NSGraphicsContext.current()?.cgContext else { assertionFailure(); return }
        
        NSColor.yellow.setFill()
        c.fill(self.bounds)

        // text
        let r1 = CGRect(x:50, y:250, width:40, height:30)
        "Hello".draw(with: r1, context:nil)
        
        // text with attributes
        
        let font = NSFont(name: "Courier", size: 50.0)!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attr : [String:Any] = [
            NSFontAttributeName:font,
            NSUnderlineStyleAttributeName:1,
            NSForegroundColorAttributeName:NSColor.red,
            NSParagraphStyleAttributeName: paragraphStyle
        ]
        
        let r2 = CGRect(x:50, y:100, width:300, height:50)
        
        "Swift Alps".draw(with: r2, options: [], attributes:attr)
        
        c.setStrokeColor(NSColor.black.cgColor)
        c.stroke(r2)
    }
}
