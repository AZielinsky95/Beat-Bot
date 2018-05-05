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
    public static var mix = AKMixer();
    
    private static let sampler = AKAppleSampler()
    
    public static var cMajor = [72, 74, 76, 77, 79, 81, 83, 84]
    
    public static var cMinor = [72, 74, 75, 77, 79, 80, 82, 86]
    
    public static var aFlatMinor = [72, 74, 75, 77, 79, 80, 82, 86]
    
    //public static var cMajor16 = [48, 74, 76, 77, 79, 81, 83, 84, 72 + 16, 74 + 16, 76 + 16, 77 + 16, 79 + 16, 81 + 16, 83 + 16, 112]
    
    public static var cMajorChord = [64, 68, 71, 75, 76, 80, 83, 87]
    
    public static func shiftOctave(octave:Int,scale:[Int]) ->[Int]
    {
        return scale.map { $0 + (12 * octave) }
    }
    
    // MARK: Instruments
    public static func loadVibes()
    {
        SoundBank.setUpSampler()
        try! SoundBank.sampler.loadWav("Vibes")
    }

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
    
    public static func playKick()
    {
        
    }
    
    private static func setUpSampler()
    {
        let ampedSampler = AKBooster(SoundBank.sampler, gain: 3.0)
        let delay  = AKDelay(ampedSampler)
        delay.time = SoundBank.pulse * 1.5
        delay.dryWetMix = 0.0
        delay.feedback = 0.0
        SoundBank.mix = AKMixer(delay)
        let reverb =  AKReverb(SoundBank.mix)
        reverb.dryWetMix = 0.5
        AudioKit.output = reverb
    }
    
    public static func playNote(note:Int,velocity:Double,channel:Int)
    {
        try! SoundBank.sampler.play(noteNumber: MIDINoteNumber(note), velocity: MIDIVelocity(velocity), channel: MIDIChannel(channel))
    }
}
