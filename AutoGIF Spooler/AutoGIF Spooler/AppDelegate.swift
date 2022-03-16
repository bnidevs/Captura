//
//  AppDelegate.swift
//  AutoGIF Spooler
//
//  Created by Bill Ni on 2/12/22.
//

import Foundation
import Cocoa
import SwiftUI

class AppData: ObservableObject {
    @Published var recorder: Recorder = Recorder()
    @Published var statusBar: StatusBarController?
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var popover = NSPopover.init()
    
    @ObservedObject var appdata: AppData = AppData.init()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let contentView = ContentView(recorder: $appdata.recorder, sbc: $appdata.statusBar)
        popover.contentViewController = NSHostingController(rootView: contentView)
        appdata.statusBar = StatusBarController.init(popover)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        appdata.recorder.startStop()
        while(appdata.recorder.recorder.isRecording){
            
        }
    }
}
