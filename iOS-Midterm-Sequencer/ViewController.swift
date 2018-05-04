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
        self.SetupGrid()

        audioManager.metronome.callback =
        {
            let deadlineTime = DispatchTime.now() + (90 / self.audioManager.tempo) / 10.0
            DispatchQueue.main.asyncAfter(deadline: deadlineTime)
            {
                self.audioManager.currentStep += 1;
                if(self.audioManager.currentStep > (self.gridManager.gridX - 1))
                {
                    self.audioManager.currentStep = 0
                }
                print("TICK")
                self.animateColumn(x: self.audioManager.currentStep)
            }
        }
        
        AudioKit.output = self.audioManager.metronome
        try! AudioKit.start()
        audioManager.startSequencer()
    }
    
    func SetupGrid()
    {
        // Do any additional setup after loading the view, typically from a nib.
        
        gridManager.createGrid()
        
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
                gridManager.grid[y][x].widthAnchor.constraint(equalToConstant: 40).isActive = true
                gridManager.grid[y][x].heightAnchor.constraint(equalToConstant: 40).isActive = true
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
            UIView.animate(withDuration: 0.2, animations: {
                self.gridManager.grid[y][x].alpha = 0.75
            }) { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.gridManager.grid[y][x].alpha = 1
                })
            }
        }
    }
    
    @IBAction func testColumnAnimation(_ sender: UIButton) {
        animateColumn(x: 0)
    }
}

