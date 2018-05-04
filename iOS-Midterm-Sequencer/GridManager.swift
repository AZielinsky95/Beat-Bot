//
//  GridManager.swift
//  iOS-Midterm-Sequencer
//
//  Created by Alejandro Zielinsky on 2018-05-03.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit

class GridManager: NSObject
{
    var grid = [[GridCell]]()
    let gridX : Int = 8
    let gridY : Int = 8

    
    func createGrid(width:Int,height:Int) {
        let frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        SoundBank.cMajorChord.reverse()
        for y in 0..<gridY {
            grid.append(Array())
            for x in 0..<gridX {
                self.grid[y].append(GridCell(frame: frame,note: SoundBank.cMajorChord[y]))
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
