//
//  AudioManager.swift
//  iOS-Midterm-Sequencer (Sequencer++)
//
//  Created by Alejandro Zielinsky & Mike Stoltman on 2018-05-03.
//  Copyright © 2018 Alejandro Zielinsky & Mike Stoltman. All rights reserved.
//

import UIKit
import AudioKit

class AudioManager: NSObject
{
    let metronome = AKMetronome()
    var tempo = 160.0
    var currentStep = -1
    
    var volume: Double
    {
        get
        {
            return SoundBank.volume
        }
        set
        {
            SoundBank.volume = newValue
        }
    }
    
    override init()
    {
        self.metronome.frequency1 = 0;
        self.metronome.frequency2 = 0;
        self.metronome.tempo = tempo;
        SoundBank.setUpSampler()
        SoundBank.loadPiano()
    }
    
    func setTempo(tempo:Double)
    {
        self.metronome.tempo = tempo;
    }
    
    func startSequencer()
    {
        self.metronome.start();
    }
    
    func stopSequencer()
    {
        self.metronome.stop();
    }

}
