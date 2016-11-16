//
//  AppDelegate.swift
//  SwiftDrawing
//
//  Created by nst on 06.11.16.
//  Copyright © 2016 Nicolas Seriot. All rights reserved.
//

import Cocoa
import ObjectiveC

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var customView: NSView!
    @IBOutlet weak var arrayController: NSArrayController!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let classNames = [
            "DrawLine1",
            "DrawLine2",
            "DrawRect",
            "DrawEllipse",
            "DrawComposition",
            "DrawCompositionAlpha",
            "DrawCompositionBlending",
            "DrawPath",
            "DrawText",
            "DrawClipping",
            "DrawGradient",
            "DrawImage",
            "DrawImageFiltered",
            "DrawPushAndPop",
            "DrawTransforms",
            "DrawInteractions",
            "DrawLayers",
            "DrawLayersLines"
        ]
        
        for s in classNames {
            
            guard let _ = NSObject.fullClassName(className: s) as? NSView.Type else {
                assertionFailure("Class \(s) does not exist");
                return }
            
            self.arrayController.addObject(["name":s, "class":s])
        }
        
        if let firstClassName = classNames.first {
            displayViewForClassName(firstClassName)
            self.arrayController.setSelectionIndex(0)
        }

        arrayController.addObserver(self, forKeyPath: #keyPath(NSArrayController.selection), options: [], context: nil)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let d = self.arrayController.selectedObjects.first as? [String:String] else {
            for v in customView.subviews {
                v.removeFromSuperview()
            }
            return
        }
        
        guard let s = d["class"] else { assertionFailure(); return }
        
        displayViewForClassName(s)
    }
    
    func displayViewForClassName(_ s:String) {
        guard let C = NSObject.fullClassName(className: s) as? NSView.Type else {
            assertionFailure("Class \(s) does not exist");
            return }
        
        let newView = C.init(frame:customView.bounds)
        
        if let subview = customView.subviews.last {
            customView.replaceSubview(subview, with: newView)
        } else {
            customView.addSubview(newView)
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func save(sender: NSMenuItem) {
        Swift.print("-- save")
        
        guard let d = arrayController.selectedObjects.last as? [String:String] else { return }
        guard let name = d["name"] else { return }
        
        let pdfData = customView.dataWithPDF(inside: customView.bounds)
        
        let panel = NSSavePanel()
        panel.nameFieldStringValue = "\(name).pdf"
        panel.beginSheetModal(for: self.window) { (result:Int) in
            //assert(Thread.main.isMainThread)
            if result == NSFileHandlingPanelOKButton {
                guard let url = panel.url else { return }
                do {
                    try pdfData.write(to: url)
                } catch let e {
                    print(e)
                }
            }
        }
    }

    @IBAction func saveAll(sender: NSMenuItem) {
        Swift.print("-- saveAll")
        
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.canCreateDirectories = true
        panel.prompt = "Save all views"
        panel.beginSheetModal(for: self.window) { (result:Int) in
            //assert(Thread.main.isMainThread)
            if result == NSFileHandlingPanelOKButton {
                guard let url = panel.url else { return }

                for o in self.arrayController.arrangedObjects as! NSArray {
                    guard let d = o as? [String:String] else { continue }
                    guard let name = d["name"] else { return }
                    guard let className = d["class"] else { return }
                    
                    guard let C = NSObject.fullClassName(className: className) as? NSView.Type else {
                        assertionFailure("Class \(className) does not exist");
                        return }
                    
                    let view = C.init(frame:self.customView.bounds)
                    let pdfData = view.dataWithPDF(inside: self.customView.bounds)

                    let fileURL = url.appendingPathComponent("\(name).pdf")
                    
                    do {
                        try pdfData.write(to: fileURL)
                    } catch let e {
                        print(e)
                    }
                }                
            }
        }
    }
}

extension NSObject {
    class func fullClassName(className : String) -> AnyClass? {
        let bundleName = Bundle.main.infoDictionary!["CFBundleName"] as! String
        return NSClassFromString("\(bundleName).\(className)")
    }
}
