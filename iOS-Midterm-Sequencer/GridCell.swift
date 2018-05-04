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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(toggleCell), for: UIControlEvents.touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("don't call this.")
    }
    
    var isActive : Bool = false
    let activeColor : UIColor = UIColor.green;
    public static let inActiveColor : UIColor = UIColor.gray;
    
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
