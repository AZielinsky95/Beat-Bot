//
//  AudioManager.swift
//  iOS-Midterm-Sequencer
//
//  Created by Alejandro Zielinsky on 2018-05-03.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit
import AudioKit

class AudioManager: NSObject
{
    
    var audioplayer = AVAudioPlayer()
    let metronome = AKMetronome()
    var tempo = 60.0
    var currentStep = -1
    
    override init()
    {
        self.metronome.frequency1 = 0;
        self.metronome.frequency2 = 0;
    }
    
    func playSound()
    {
        self.audioplayer.play()
    }
    
    func setTempo(tempo:Double)
    {
        self.tempo = tempo;
    }
    
    func startSequencer()
    {
        metronome.start();
    }
    
    func stopSequencer()
    {
        metronome.stop();
    }

}
