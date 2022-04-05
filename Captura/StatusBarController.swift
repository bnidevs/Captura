//
//  StatusBarController.swift
//  AutoGIF Spooler
//
//  Created by Bill Ni on 2/12/22.
//

import Foundation
import AppKit

class StatusBarController {
    
    private var statusItem: NSStatusItem
    public var popover: NSPopover
    private var recording: Bool = false
    
    init(_ popover: NSPopover) {
        self.popover = popover
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let statusBarButton = statusItem.button {
            statusBarButton.image = NSImage(imageLiteralResourceName: "MenuBarIcon")
            statusBarButton.image?.size = NSSize(width: NSStatusBar.system.thickness, height: NSStatusBar.system.thickness)
            statusBarButton.image?.isTemplate = !recording
            statusBarButton.action = #selector(togglePopover(sender:))
            statusBarButton.target = self
        }
    }
    
    @objc func togglePopover(sender: AnyObject) {
        if(popover.isShown) {
            hidePopover(sender)
        }
        else {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject) {
        if let statusBarButton = statusItem.button {
            popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
        }
    }
    
    func hidePopover(_ sender: AnyObject) {
        popover.performClose(sender)
    }
    
    func toggleImg() {
        recording = !recording
        if let statusBarButton = statusItem.button {
            if recording {
                statusBarButton.image = NSImage(imageLiteralResourceName: "RecordingIcon")
            }else{
                statusBarButton.image = NSImage(imageLiteralResourceName: "MenuBarIcon")
            }
            statusBarButton.image?.size = NSSize(width: NSStatusBar.system.thickness, height: NSStatusBar.system.thickness)
            statusBarButton.image?.isTemplate = !self.recording
            statusBarButton.action = #selector(togglePopover(sender:))
            statusBarButton.target = self
        }
    }
}
