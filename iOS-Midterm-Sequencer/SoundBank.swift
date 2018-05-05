//
//  SoundBank.swift
//  iOS-Midterm-Sequencer (Sequencer++)
//
//  Created by Alejandro Zielinsky & Mike Stoltman on 2018-05-04.
//  Copyright © 2018 Alejandro Zielinsky & Mike Stoltman. All rights reserved.
//

import UIKit
import AudioKit

class SoundBank: NSObject
{
    enum Instrument
    {
        case Piano
        case Guitar
        case Marimba
        case Flute
        case Strings
    }
    
    static var currentInstrument = SoundBank.Instrument.Piano
    
    private static let pulse = 0.23
    
    private static var mix = AKMixer();
    
    static var volume : Double
    {
        get
        {
            return mix.volume
        }
        set
        {
            mix.volume = newValue
        }
    }
    
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
        currentInstrument = SoundBank.Instrument.Piano
    }
    
    public static func loadMarimba()
    {
        SoundBank.setUpSampler()
        try! SoundBank.sampler.loadWav("Marimba")
        currentInstrument = SoundBank.Instrument.Marimba
    }
    
    public static func loadGuitar()
    {
        SoundBank.setUpSampler()
        try! SoundBank.sampler.loadWav("Guitar2")
        currentInstrument = SoundBank.Instrument.Guitar
    }
    
    public static func loadFlute()
    {
        SoundBank.setUpSampler()
        try! SoundBank.sampler.loadWav("Flute")
         currentInstrument = SoundBank.Instrument.Flute
    }
    
    public static func loadClav()
    {
        SoundBank.setUpSampler()
        try! SoundBank.sampler.loadWav("Clav")
    }
    
    public static func loadStrings()
    {
        SoundBank.setUpSampler()
        try! SoundBank.sampler.loadWav("Strings")
        currentInstrument = SoundBank.Instrument.Strings
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
