//
//  ViewController.swift
//  iOS-Midterm-Sequencer
//
//  Created by Alejandro Zielinsky on 2018-05-03.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {

    let gridManager = GridManager()
    let audioManager = AudioManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.createGridForScreenSize()

        audioManager.metronome.callback =
        {
            let deadlineTime = DispatchTime.now() + (self.audioManager.tempo / self.audioManager.metronome.tempo) / 10.0
            DispatchQueue.main.asyncAfter(deadline: deadlineTime)
            {
                self.audioManager.currentStep += 1;
                if(self.audioManager.currentStep > (self.gridManager.gridX - 1))
                {
                    self.audioManager.currentStep = 0
                }
                self.animateColumn(x: self.audioManager.currentStep)
            }
        }
        
        AudioKit.output = self.audioManager.metronome
        try! AudioKit.start()
        audioManager.startSequencer()
    }
    
    func createGridForScreenSize()
    {
            switch UIScreen.main.nativeBounds.width {
            case 640:
                setupGrid(width:30,height:30) //iPhone 5, 5C, 5S, iPod Touch 5g
            case 750,1125:
                setupGrid(width:40,height:40) //iPhone 6, iPhone 6s, iPhone 7/8 OR  //print("iphonex")
            case 1242:
                setupGrid(width:45,height:45) //iPhone 6 Plus, iPhone 6s Plus, iPhone 7 Plus
            case 1536:
                setupGrid(width:55,height:55)//iPad 3, iPad 4, iPad Air, iPad Air 2, 9.7-inch iPad Pro
            default:
                setupGrid(width:40,height:40) 
            }
    }
    
    func setupGrid(width:Int,height:Int)
    {

       gridManager.createGrid(width:width,height:height)
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 5
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for y in 0..<gridManager.gridY
        {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.spacing = 5
            rowStackView.translatesAutoresizingMaskIntoConstraints = false
            
            for x in 0..<gridManager.gridX
            {
                // add each cell to the row stackview
                rowStackView.addArrangedSubview(gridManager.grid[y][x])
                gridManager.grid[y][x].widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
                gridManager.grid[y][x].heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
            }
            // add row to main stackview
            mainStackView.addArrangedSubview(rowStackView)
        }
        // add main stackview to self.view as a subview
        self.view.addSubview(mainStackView)
        // main stackview center horizontally and vertically
        
        mainStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func animateColumn(x: Int)
    {
        for y in 0..<gridManager.gridY {
            UIView.animate(withDuration: 0.2, animations:
            {
                self.gridManager.grid[y][x].alpha = 0.75
                //Get all active cells in this row
                if(self.gridManager.grid[y][x].isActive)
                {
                   self.gridManager.grid[y][x].playNote()
                   self.gridManager.grid[y][x].scaleUp()
                }
            })
            { _ in
                UIView.animate(withDuration: 0.2, animations:
                {
                    self.gridManager.grid[y][x].alpha = 1
                    self.gridManager.grid[y][x].setOriginalScale()
                })
            }
        }
    }
    
    @IBAction func testColumnAnimation(_ sender: UIButton) {
        animateColumn(x: 0)
    }
}

