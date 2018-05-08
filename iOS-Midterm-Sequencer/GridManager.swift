//
//  GridManager.swift
//  iOS-Midterm-Sequencer (Sequencer++)
//
//  Created by Alejandro Zielinsky & Mike Stoltman on 2018-05-03.
//  Copyright © 2018 Alejandro Zielinsky & Mike Stoltman. All rights reserved.
//

import UIKit

class GridManager: NSObject
{
    var grid = [[GridCell]]()
    let gridX : Int = 16
    let gridY : Int = 16

    //test
    func updateGridCellColor(color:UIColor)
    {
        GridCell.activeColor = color
        
        for row in self.grid
        {
            for cell in row
            {
                if(cell.isActive && (cell.gridNote != 0 || cell.gridNote != 1 || cell.gridNote != 2))
                {
                    cell.updateColor(color: color)
                }
            }
        }
    }
    
    func createGrid(width:Int,height:Int)
    {
        let frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        SoundBank.dFlatMajor16.reverse()
        SoundBank.dFlatMajor16 = SoundBank.shiftOctave(octave: -1, scale: SoundBank.dFlatMajor16)
        for y in 0..<gridY
        {
            grid.append(Array())
            
            for x in 0..<gridX
            {
                if(y  == 13 || y == 14 || y == 15)
                {
                    if(y == 13)
                    {
                     self.grid[y].append(GridCell(frame: frame,note:2))
                    }
                    else if(y == 14)
                    {
                     self.grid[y].append(GridCell(frame: frame,note:1))
                    }
                    else if(y == 15)
                    {
                     self.grid[y].append(GridCell(frame: frame,note:0))
                    }
                }
                else
                {
                  self.grid[y].append(GridCell(frame: frame,note: SoundBank.dFlatMajor16[y]))
                }
                
              self.grid[y][x].backgroundColor = GridCell.inActiveColor
            }
        }
    }
    
    func resetGrid()
    {
       for row in self.grid
       {
         for cell in row
         {
            if(cell.isActive)
            {
                cell.toggleCell()
            }
         }
       }
    }
    
}
