//
//  GridCell.swift
//  iOS-Midterm-Sequencer
//
//  Created by Alejandro Zielinsky on 2018-05-03.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit

class GridCell: UIButton
{
    var isActive : Bool = false
    let activeColor : UIColor = UIColor.cyan;
    var gridNote : Int = 0;
    public static let inActiveColor : UIColor = UIColor.gray;
    
    init(frame: CGRect,note:Int)
    {
        super.init(frame: frame)
        self.gridNote = note
        self.addTarget(self, action: #selector(toggleCell), for: UIControlEvents.touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("don't call this.")
    }
    
    func playNote()
    {
        SoundBank.playNote(note: self.gridNote, velocity: 100, channel: 1)
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
            self.backgroundColor = activeColor;
            self.isActive = true;
        }
    }
}
