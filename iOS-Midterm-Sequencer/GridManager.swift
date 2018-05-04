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

    
    func createGrid() {
        let frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        for i in 0..<gridX {
            grid.append(Array())
            for j in 0..<gridY {
                self.grid[i].append(GridCell(frame: frame))
                self.grid[i][j].backgroundColor = GridCell.inActiveColor
            }
        }
    }
}
