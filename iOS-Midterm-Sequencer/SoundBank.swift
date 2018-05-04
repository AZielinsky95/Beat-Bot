//
//  SoundBank.swift
//  iOS-Midterm-Sequencer
//
//  Created by Alejandro Zielinsky on 2018-05-04.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit
import AudioKit

class SoundBank: NSObject
{
    private static let pulse = 0.23
    
    private static let sampler = AKAppleSampler()
    
    public static let cMajor = [72, 74, 76, 77, 79, 81, 83, 84]
    
    public static func loadPiano()
    {
        SoundBank.setUpSampler()
        try! SoundBank.sampler.loadWav("FM Piano")
    }
    
    private static func setUpSampler()
    {
        let ampedSampler = AKBooster(SoundBank.sampler, gain: 3.0)
        let delay  = AKDelay(ampedSampler)
        delay.time = SoundBank.pulse * 1.5
        delay.dryWetMix = 0.0
        delay.feedback = 0.0
        let mix = AKMixer(delay)
        let reverb = AKReverb(mix)
        AudioKit.output = reverb
//        try! AudioKit.start()
    }
    
    public static func playNote(note:Int,velocity:Double,channel:Int)
    {
        try! SoundBank.sampler.play(noteNumber: MIDINoteNumber(note), velocity: MIDIVelocity(velocity), channel: MIDIChannel(channel))
    }
    
    //    for note in cMajor {
    //    try! sampler.play(noteNumber: MIDINoteNumber(note), velocity: 100, channel: 1)
    //    sleep(1)
    //    }
    
}
