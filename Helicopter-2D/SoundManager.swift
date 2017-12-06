//
//  SoundManager.swift
//  Helicopter-2D
//
//  Created by Kristina Gelzinyte on 12/5/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import AVFoundation

class SoundManager: NSObject, AVAudioPlayerDelegate {
    
    static let sharedInstance = SoundManager()
    
    var audioPlayer: AVAudioPlayer?
    var trackPosition = 0
    
    ///Defines if the game is muted.
    private(set) var isMuted = false
    
    //Music: http://www.bensound.com/royalty-free-music
    static private let tracks = [
//        "slowmotion",
        "scifi"
    ]
    
    private override init(){
        //This let to create only one `SoundManager ever`.
        trackPosition = Int( arc4random_uniform( UInt32(SoundManager.tracks.count)))
        
        let defaults = UserDefaults.standard
        isMuted = defaults.bool(forKey: MuteKey)
    }
    
    public func startPlaying(){
        if !isMuted && (audioPlayer == nil || audioPlayer?.isPlaying == false) {

            let soundURL = Bundle.main.url(forResource: SoundManager.tracks[trackPosition], withExtension: "mp3")
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
                audioPlayer?.delegate = self
            } catch {
                print("Audio player failed to load.")
                
                startPlaying()
            }
            
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            trackPosition = (trackPosition + 1) % SoundManager.tracks.count
        } else {
            print("Audio player is already playing!")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        //Plays the next track.
        startPlaying()
    }
    
    
    ///Sets the audio state for the game and saves it in `UserDefaults`
    func toggleMute() -> Bool {
        isMuted = !isMuted
        
        let defaults = UserDefaults.standard
        defaults.set(isMuted, forKey: MuteKey)
        defaults.synchronize()
        
        if isMuted {
            audioPlayer?.stop()
        } else {
            startPlaying()
        }
        return isMuted
    }
    
}

