//
//  ViewController.swift
//  iOS-Midterm-Sequencer (Sequencer++)
//
//  Created by Alejandro Zielinsky & Mike Stoltman on 2018-05-03.
//  Copyright © 2018 Alejandro Zielinsky & Mike Stoltman. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {

    let gridManager = GridManager()
    let audioManager = AudioManager()
    var mainStackView = UIStackView()
    var isPlaying = false
//    var currentInstrument = "drums"
    
    @IBOutlet weak var topMenuView: UIView!
    @IBOutlet weak var bottomMenuView: UIView!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var tempoSlider: UISlider!
    @IBOutlet weak var volumeValueLabel: UILabel!
    @IBOutlet weak var tempoValueLabel: UILabel!
    @IBOutlet weak var instrument01Button: UIButton!
    @IBOutlet weak var instrument02Button: UIButton!
    @IBOutlet weak var instrument03Button: UIButton!
    @IBOutlet weak var instrument04Button: UIButton!
    @IBOutlet weak var instrument05Button: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var menuButtons = [UIButton]()
    
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
        
        self.setupSliders()
        
        self.menuButtons.append(contentsOf: [instrument01Button,instrument02Button,instrument03Button,instrument04Button,instrument05Button,playButton,resetButton]);
        
        self.gridManager.updateGridCellColor(color: UIColor.init(red: (255/255), green: (105/255), blue: (120/255), alpha: 1))
        updateMenuColors()
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
        
        self.mainStackView = UIStackView()
        self.mainStackView.axis = .vertical
        self.mainStackView.spacing = 5
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
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
                
                // rounding the corners a little bit
                gridManager.grid[y][x].layer.cornerRadius = 5
                
                // code to make them circles (if we want to switch)
//                gridManager.grid[y][x].layer.cornerRadius = (gridManager.grid[y][x].layer.frame.width/2)
                
            }
            // add row to main stackview
            self.mainStackView.addArrangedSubview(rowStackView)
        }
        // add main stackview to self.view as a subview
        self.view.addSubview(mainStackView)
        // main stackview center horizontally and vertically
        
        self.mainStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.mainStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.alignMenus()
        
    }
    
    func setupSliders()
    {
        self.volumeSlider.minimumValue = 0
        self.volumeSlider.maximumValue = 100
        self.volumeSlider.value = 100
        let volumeValue = 100;
        self.volumeValueLabel.text = volumeValue.description
        
        self.tempoSlider.minimumValue = 60
        self.tempoSlider.maximumValue = 240
        self.tempoSlider.value = Float(self.audioManager.tempo)
        let tempoValue = Int(self.audioManager.tempo)
        self.tempoValueLabel.text = tempoValue.description
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
    
    func alignMenus()
    {
        self.topMenuView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.topMenuView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.topMenuView.bottomAnchor.constraint(equalTo: self.mainStackView.topAnchor, constant: -10).isActive = true
        
        self.bottomMenuView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.bottomMenuView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.bottomMenuView.topAnchor.constraint(equalTo: self.mainStackView.bottomAnchor, constant: 30).isActive = true
        
        self.roundCorners()
        self.resizeIcons()
    }
    
    func roundCorners()
    {
        self.playButton.layer.cornerRadius = 10
        self.playButton.superview!.layer.cornerRadius = 10
        self.resetButton.layer.cornerRadius = 10
        self.resetButton.superview!.layer.cornerRadius = 10
        self.instrument01Button.layer.cornerRadius = 10
        self.instrument01Button.superview!.layer.cornerRadius = 10
        self.instrument02Button.layer.cornerRadius = 10
        self.instrument02Button.superview!.layer.cornerRadius = 10
        self.instrument03Button.layer.cornerRadius = 10
        self.instrument03Button.superview!.layer.cornerRadius = 10
        self.instrument04Button.layer.cornerRadius = 10
        self.instrument04Button.superview!.layer.cornerRadius = 10
        self.instrument05Button.layer.cornerRadius = 10
        self.instrument05Button.superview!.layer.cornerRadius = 10

    }
    
    func resizeIcons()
    {
        let edgeInset: CGFloat = 15
        self.instrument01Button.imageEdgeInsets.top = edgeInset*1.5
        self.instrument01Button.imageEdgeInsets.bottom = edgeInset*1.5
        self.instrument01Button.imageEdgeInsets.left = edgeInset
        self.instrument01Button.imageEdgeInsets.right = edgeInset
        
        self.instrument02Button.imageEdgeInsets.top = edgeInset*1.5
        self.instrument02Button.imageEdgeInsets.bottom = edgeInset*1.5
        self.instrument02Button.imageEdgeInsets.left = edgeInset
        self.instrument02Button.imageEdgeInsets.right = edgeInset
        
        self.instrument03Button.imageEdgeInsets.top = edgeInset*1.5
        self.instrument03Button.imageEdgeInsets.bottom = edgeInset*1.5
        self.instrument03Button.imageEdgeInsets.left = edgeInset
        self.instrument03Button.imageEdgeInsets.right = edgeInset
        
        self.instrument04Button.imageEdgeInsets.top = edgeInset*1.5
        self.instrument04Button.imageEdgeInsets.bottom = edgeInset*1.5
        self.instrument04Button.imageEdgeInsets.left = edgeInset
        self.instrument04Button.imageEdgeInsets.right = edgeInset
        
        self.instrument05Button.imageEdgeInsets.top = edgeInset*1.5
        self.instrument05Button.imageEdgeInsets.bottom = edgeInset*1.5
        self.instrument05Button.imageEdgeInsets.left = edgeInset
        self.instrument05Button.imageEdgeInsets.right = edgeInset
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton)
    {
        if isPlaying
        {
            audioManager.stopSequencer()
            isPlaying = false
            self.playButton.setBackgroundImage(UIImage.init(named: "icon_play"), for: UIControlState.normal)
        }else
        {
            audioManager.startSequencer()
            isPlaying = true
            self.playButton.setBackgroundImage(UIImage.init(named: "icon_pause"), for: UIControlState.normal)
        }
    }
    
    func updateMenuColors()
    {
        for button in self.menuButtons
        {
            button.superview?.backgroundColor = GridCell.activeColor
        }
        
        volumeSlider.tintColor = GridCell.activeColor
        tempoSlider.tintColor = GridCell.activeColor
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton)
    {
        self.gridManager.resetGrid()
    }
    
    @IBAction func volumeSliderAdjusted(_ sender: UISlider)
    {
        let newValue = Int(sender.value)
        self.volumeValueLabel.text = newValue.description
        self.audioManager.volume = Double(sender.value / 100)
    }
    
    @IBAction func tempoSliderAdjusted(_ sender: UISlider)
    {
        let newValue = Int(sender.value)
        self.tempoValueLabel.text = newValue.description
        self.audioManager.metronome.tempo = Double(sender.value)
    }
    
    @IBAction func instrument01ButtonTapped(_ sender: UIButton)
    {
        if(SoundBank.currentInstrument != SoundBank.Instrument.Piano)
        {
        self.gridManager.updateGridCellColor(color: UIColor.init(red: (255/255), green: (105/255), blue: (120/255), alpha: 1))
        updateMenuColors()
        SoundBank.loadPiano()
        }
    }
    
    @IBAction func instrument02ButtonTapped(_ sender: UIButton)
    {
        if(SoundBank.currentInstrument != SoundBank.Instrument.Guitar)
        {
        self.gridManager.updateGridCellColor(color: UIColor.init(red: (93/255), green: (211/255), blue: (158/255), alpha: 1))
        updateMenuColors()
        SoundBank.loadGuitar()
        }
    }
    
    @IBAction func instrument03ButtonTapped(_ sender: UIButton)
    {
        if(SoundBank.currentInstrument != SoundBank.Instrument.Strings)
        {
        self.gridManager.updateGridCellColor(color: UIColor.init(red: (52/255), green: (191/255), blue: (222/255), alpha: 1))
        updateMenuColors()
        SoundBank.loadStrings()
        }
    }
    
    @IBAction func instrument04ButtonTapped(_ sender: UIButton)
    {
        if(SoundBank.currentInstrument != SoundBank.Instrument.Flute)
        {
        self.gridManager.updateGridCellColor(color: UIColor.init(red: (255/255), green: (240/255), blue: (124/255), alpha: 1))
        updateMenuColors()
        SoundBank.loadFlute()
        }
    }
    
    @IBAction func instrument05ButtonTapped(_ sender: UIButton)
    {
        if(SoundBank.currentInstrument != SoundBank.Instrument.Marimba)
        {
        self.gridManager.updateGridCellColor(color: UIColor.init(red: (89/255), green: (248/255), blue: (232/255), alpha: 1))
        updateMenuColors()
        SoundBank.loadMarimba()
        }
    }
    
    //    override func viewDidLayoutSubviews()
    //    {
    //        self.makeButtonsCircular()
    //    }
    //
    //    func makeButtonsCircular()
    //    {
    //      //  let position = self.playButton.superview!.center
    //       // self.playButton.superview!.frame = CGRect(x: position.x, y: position.y, width: 100, height: 100)
    //       // self.playButton.frame = CGRect(x:  self.playButton.center.x, y: self.playButton.center.y, width: 50, height: 50)
    //        self.playButton.superview?.layer.cornerRadius = 0.5 * (self.playButton.superview?.bounds.size.width)!
    //        self.playButton.layer.cornerRadius = 0.5 * playButton.bounds.size.width
    //
    //        self.resetButton.superview?.layer.cornerRadius = 0.5 * (self.resetButton.superview?.bounds.size.width)!
    //        self.resetButton.layer.cornerRadius = 0.5 * resetButton.bounds.size.width
    //
    //    }
    
    
}

