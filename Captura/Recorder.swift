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
    public var fileName: URL = genFilename()
    // false == WEBM, true == GIF
    
    init() {
        recorder = try! Aperture(destination: fileName, videoCodec: AVVideoCodecType.h264)
    }

    func startStop(){
        if(recorder.isRecording){
            recorder.stop()
            fileName = genFilename()
            recorder = try! Aperture(destination: fileName, videoCodec: AVVideoCodecType.h264)
        }else{
            recorder.start()
        }
    }

    func changeFileType(){
        fileType = !fileType;
    }
}

func genFilename() -> URL {
    let paths = FileManager.default.urls(for: .moviesDirectory, in: .userDomainMask)
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "yyyy-MM-dd--HHmmss"
    dateformatter.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
    let url = URL(string: paths[0].absoluteString + "Captura-" + dateformatter.string(from: Date()) + ".mp4")!
    return url
}
