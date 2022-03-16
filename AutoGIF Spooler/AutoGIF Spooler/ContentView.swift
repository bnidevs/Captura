//
//  ContentView.swift
//  AutoGIF Spooler
//
//  Created by Bill Ni on 2/12/22.
//

import SwiftUI
import Aperture

struct ContentView: View {
    @Binding public var recorder: Recorder
    @Binding public var sbc: StatusBarController?
    
    @State public var recordingState = false
    @State public var fileType = true
    @State public var writing = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("AutoGIF")
                .font(.system(size: 18, weight: .bold))
                .padding([.leading], 10)
            VStack(alignment: .center){
                HStack(alignment: .center, spacing: 10){
                    Text("Recording")
                        .font(.system(size: 16, weight: .semibold))
                    Circle()
                        .fill(recordingState ? Color.red : Color.gray)
                        .frame(width: 10, height: 10)
                    Spacer()
                    Button(recordingState ? "Stop" : "Start", action: callSS)
                }
                    .frame(width: 200, height: 25, alignment: .topLeading)
                HStack(alignment: .center, spacing: 10){
                    Text("Saves: ")
                        .bold()
                    Spacer()
                    Link("/Users/" + NSUserName() + "/Movies", destination: URL(fileURLWithPath: FileManager.default.urls(for: .moviesDirectory, in: .userDomainMask)[0].absoluteString))
                        .environment(\.openURL, OpenURLAction { url in
                            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: "/Users/" + NSUserName() + "/Movies")
                            return .handled
                        })
                }
                    .frame(width: 200, height: 20, alignment: .topLeading)
            }
                .frame(width: 200, height: 50)
                .padding(10)
                .background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.3))
                .cornerRadius(5)
            HStack(alignment: .center){
                Spacer()
                Button("Quit", action: menuQuit)
                    .disabled(writing)
            }
                .frame(width: 200, height: 10, alignment: .center)
                .padding(10)
        }
            .frame(width: 200, height: 130, alignment: .center)
            .padding(20)
    }
    
    func callSS(){
        recordingState = !recordingState
        recorder.startStop()
        if(recordingState){
            sbc?.toggleImg()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                sbc?.togglePopover(sender: 1 as NSNumber)
            }
        }else{
            sbc?.toggleImg()
        }
    }
    
    func switchFT(){
        fileType = !fileType
//        apd.recorder.changeFileType()
    }
    
    func menuQuit(){
        recorder.startStop()
        while(recorder.recorder.isRecording){
            
        }
        NSApp.terminate(self)
    }
}
