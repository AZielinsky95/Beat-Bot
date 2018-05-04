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
    let metronome = AKMetronome()
    var tempo = 160.0
    var currentStep = -1
    
    override init()
    {
        self.metronome.frequency1 = 0;
        self.metronome.frequency2 = 0;
        self.metronome.tempo = tempo;
        SoundBank.loadGuitar()
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
