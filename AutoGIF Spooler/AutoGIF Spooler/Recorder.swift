//
//  Functionals.swift
//  AutoGIF Spooler
//
//  Created by Bill Ni on 2/12/22.
//

import Foundation
import Aperture
import AVFoundation

class Recorder {
    public var recorder: Aperture!
    public var fileType: Bool = false
    // false == WEBM, true == GIF
    
    init() {
        recorder = try! Aperture(destination: genFilename(), videoCodec: AVVideoCodecType.h264)
    }

    func startStop(){
        if(recorder.isRecording){
            recorder.stop()
            recorder = try! Aperture(destination: self.genFilename(), videoCodec: AVVideoCodecType.h264)
        }else{
            recorder.start()
        }
    }

    func changeFileType(){
        fileType = !fileType;
    }
    
    func genFilename() -> URL {
        let paths = FileManager.default.urls(for: .moviesDirectory, in: .userDomainMask)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd--HH:mm:ss"
        let url = URL(string: paths[0].absoluteString + "AutoGIF-" + dateformatter.string(from: Date()) + ".mp4")!
        return url
    }
}
