//
//  GridCell.swift
//  iOS-Midterm-Sequencer (Sequencer++)
//
//  Created by Alejandro Zielinsky & Mike Stoltman on 2018-05-03.
//  Copyright © 2018 Alejandro Zielinsky & Mike Stoltman. All rights reserved.
//

import UIKit
import AudioKit

class GridCell: UIButton
{
    var isActive : Bool = false
    static var activeColor: UIColor = UIColor.cyan;
    static let inActiveColor : UIColor = UIColor.gray;
    
    var gridNote : Int = 0;
    

    var kick = AVAudioPlayer()
    var snare = AVAudioPlayer()
    var hat = AVAudioPlayer()
    
    init(frame: CGRect,note:Int)
    {
        super.init(frame: frame)
        self.gridNote = note
        self.addTarget(self, action: #selector(toggleCell), for: UIControlEvents.touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("don't call this.")
    }
    
    func updateColor(color:UIColor)
    {
        self.backgroundColor =  GridCell.activeColor
    }
    
    func playNote()
    {
        SoundBank.playNote(note: self.gridNote, velocity: 140, channel: 1)
    }
    
    func scaleUp()
    {
      self.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
    }
    
    func setOriginalScale()
    {
      self.transform = CGAffineTransform.identity
    }
    
    public func setUpDrums()
    {
        let kickPath = Bundle.main.path(forResource: "Kick.wav", ofType:nil)!
        let kickUrl = URL(fileURLWithPath: kickPath)
        kick = try! AVAudioPlayer(contentsOf: kickUrl)
        kick.prepareToPlay()
        
        let snarePath = Bundle.main.path(forResource: "Snare.wav", ofType:nil)!
        let snareURL = URL(fileURLWithPath: snarePath)
        snare = try! AVAudioPlayer(contentsOf: snareURL)
        snare.prepareToPlay()
        
        let hatPath = Bundle.main.path(forResource: "Hat.wav", ofType:nil)!
        let hatURL = URL(fileURLWithPath: hatPath)
        hat = try! AVAudioPlayer(contentsOf: hatURL)
        hat.prepareToPlay()
    }
    
    public func playDrumNote(note:Int)
    {
        switch note
        {
        case 0:
            kick.stop()
            kick.play()
        case 1:
            snare.stop()
            snare.play()
        case 2:
            hat.stop()
            hat.play()
        default:
            print("DRUM NOTE FAILED");
        }
    }
    
    @objc func toggleCell()
    {
        if(self.isActive)
        {
            self.backgroundColor = GridCell.inActiveColor;
            self.isActive = false;
        }
        else
        {
            self.backgroundColor =  GridCell.activeColor;
            self.isActive = true;
        }
    }
}
