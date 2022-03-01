//
//  AudioPlayer.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 2/25/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import FirebaseStorage
import AVFoundation

class AudioPlayer:  NSObject, ObservableObject, AVAudioPlayerDelegate  {
    @Published var duration = 0.0
    
    var audioPlayer: AVAudioPlayer!
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func getDuration (url: String) {
        let str = url.split(separator: "/").last!
        let foo = str.split(separator: "?").first!
        let newString = foo.replacingOccurrences(of: "%2F", with: "/")
        
        let storage = Storage.storage()
        let ref = storage.reference(withPath: newString)
        ref.downloadURL { hardURL, err in
            if err == nil, let url = hardURL {
                do {
                    let session = AVAudioSession.sharedInstance()
                    try session.setCategory(AVAudioSession.Category.playback)
                    let soundData = try Data(contentsOf: url)
                    self.audioPlayer = try AVAudioPlayer(data: soundData)
                    self.duration = CGFloat(self.audioPlayer.duration)
                } catch {
                    print("error here")
                }
            }
        }
    }
    
    func startPlayback(audio: URL, test: String) {
        let playbackSession = AVAudioSession.sharedInstance()
        do {
            try playbackSession.setCategory(AVAudioSession.Category.playback)
        }
        catch {
            print(error)
        }
        let str = test.split(separator: "/").last!
        let foo = str.split(separator: "?").first!
        let newString = foo.replacingOccurrences(of: "%2F", with: "/")
        
        let storage = Storage.storage()
        let ref = storage.reference(withPath: newString)
        ref.downloadURL { hardURL, err in
            if err == nil, let url = hardURL {
                do {
                    let session = AVAudioSession.sharedInstance()
                    try session.setCategory(AVAudioSession.Category.playback)
                    let soundData = try Data(contentsOf: url)
                    self.audioPlayer = try AVAudioPlayer(data: soundData)
                    self.audioPlayer.prepareToPlay()
                    self.audioPlayer.play()
                    self.isPlaying = true
                } catch {
                    print("error here")
                }
            }
        }
    }
    
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            if flag {
                isPlaying = false
            }
        }
}
