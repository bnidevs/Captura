//
//  AppDelegate.swift
//  AutoGIF Spooler
//
//  Created by Bill Ni on 2/12/22.
//

import Foundation
import Cocoa
import SwiftUI
import KeyboardShortcuts

enum NoScreenAccess: Error {
    case noscreenaccess
}

class AppData: ObservableObject {
    @Published var recorder: Recorder = Recorder()
    @Published var statusBar: StatusBarController?
    
    @available(macOS, introduced: 10.15)
    @Published var recordPerm: Bool = CGPreflightScreenCaptureAccess()
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var popover = NSPopover.init()
    
    @ObservedObject var appdata: AppData = AppData.init()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let contentView = ContentView(recorder: $appdata.recorder, sbc: $appdata.statusBar, canRecord: $appdata.recordPerm)
        popover.contentViewController = NSHostingController(rootView: contentView)
        appdata.statusBar = StatusBarController.init(popover)
        
        if(!appdata.recordPerm){
            if(!CGRequestScreenCaptureAccess()){
                let errordialog = NSAlert.init(error: NoScreenAccess.noscreenaccess)
                errordialog.messageText = "Captura requires screen recording access"
                errordialog.informativeText = "Please proceed to the 'Security and Privacy' section in your System Preferences and enable permissions for Captura to record your screen, then restart the app"
                errordialog.runModal()
            }else{
                appdata.recordPerm = true
            }
        }
        
        KeyboardShortcuts.onKeyUp(for: .startstoprecord) {
            contentView.callSS()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        appdata.recorder.startStop()
        while(appdata.recorder.recorder.isRecording){
            
        }
    }
}
