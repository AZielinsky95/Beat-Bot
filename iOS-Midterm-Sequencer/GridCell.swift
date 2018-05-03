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
    let activeColor : UIColor = UIColor.green;
     let inActiveColor : UIColor = UIColor.gray;
    
    func toggleCell()
    {
        if(self.isActive)
        {
            self.backgroundColor = inActiveColor;
            self.isActive = false;
        }
        else
        {
            self.backgroundColor = activeColor;
            self.isActive = true;
        }
    }
}
