//
//  SDDrawingView.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa

class DrawImageFiltered: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let c = NSGraphicsContext.current()?.cgContext else { assertionFailure(); return }
        
        NSColor.yellow.setFill()
        c.fill(self.bounds)

        let r = CGRect(x: 20, y: 20, width: 300, height: 200)
        c.setStrokeColor(NSColor.black.cgColor)
        
        c.clip(to: r)
        
        let image = NSImage(named: "Lenna.png")!
        
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        let ciImage = CIImage(cgImage: cgImage)
        
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(5, forKey: kCIInputRadiusKey)
        
        let ciContext = CIContext(options: nil)
        let resultCIImage : CIImage = filter.value(forKey:kCIOutputImageKey) as! CIImage!
        let resultCGImage = ciContext.createCGImage(resultCIImage, from: ciImage.extent)!
        
        let filteredImage = NSImage(cgImage: resultCGImage, size: image.size)
        
        let imageRect = CGRect(x: -30, y:-50, width:image.size.width, height:image.size.height)
        
        filteredImage.draw(in: imageRect)
        
        c.stroke(r)
    }
}
