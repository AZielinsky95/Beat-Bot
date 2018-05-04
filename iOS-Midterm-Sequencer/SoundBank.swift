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
    
    public static var cMajor = [72, 74, 76, 77, 79, 81, 83, 84]
    
    public static var cMajorChord = [72-8, 76-8, 79-8, 83-8, 84-8, 88-8, 91-8, 95-8]
    
    public static func loadPiano()
    {
        SoundBank.setUpSampler()
        try! SoundBank.sampler.loadWav("FM Piano")
    }
    
    public static func loadMarimba()
    {
        SoundBank.setUpSampler()
        try! SoundBank.sampler.loadWav("Marimba")
    }
    
    public static func loadGuitar()
    {
        SoundBank.setUpSampler()
        try! SoundBank.sampler.loadWav("guitar")
    }
    
    
    public static func loadStrings()
    {
        SoundBank.setUpSampler()
        try! SoundBank.sampler.loadWav("strings")
    }
    
    
    private static func setUpSampler()
    {
        let ampedSampler = AKBooster(SoundBank.sampler, gain: 3.0)
        let delay  = AKDelay(ampedSampler)
        delay.time = SoundBank.pulse * 1.5
        delay.dryWetMix = 0.0
        delay.feedback = 0.0
        let mix = AKMixer(delay)
        let reverb =  AKReverb(mix)
        reverb.dryWetMix = 0.5

        AudioKit.output = reverb
//        try! AudioKit.start()
    }
    
    public static func playNote(note:Int,velocity:Double,channel:Int)
    {
        try! SoundBank.sampler.play(noteNumber: MIDINoteNumber(note), velocity: MIDIVelocity(velocity), channel: MIDIChannel(channel))
    }
}
