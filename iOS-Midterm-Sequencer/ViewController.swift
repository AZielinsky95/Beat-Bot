//
//  ViewController.swift
//  iOS-Midterm-Sequencer
//
//  Created by Alejandro Zielinsky on 2018-05-03.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let gridManager = GridManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetupGrid()
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
        
    }
    
}

