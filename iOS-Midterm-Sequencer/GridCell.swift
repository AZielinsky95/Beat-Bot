//
//  GridCell.swift
//  iOS-Midterm-Sequencer (Sequencer++)
//
//  Created by Alejandro Zielinsky & Mike Stoltman on 2018-05-03.
//  Copyright © 2018 Alejandro Zielinsky & Mike Stoltman. All rights reserved.
//

import UIKit

class GridCell: UIButton
{
    var isActive : Bool = false
    static var activeColor: UIColor = UIColor.cyan;
    static let inActiveColor : UIColor = UIColor.gray;
    
    var gridNote : Int = 0;
    
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
