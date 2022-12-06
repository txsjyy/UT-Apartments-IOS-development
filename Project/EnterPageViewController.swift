//
//  EnterPageViewController.swift
//  Project Name: UT Apartment
//  Team 8: Junyu Yao, Mingda Li, Ruiqi Liu
//  Course: CS329E
//
//  Created by Junyu Yao on 11/30/22.
//

import UIKit

// allow user to rotate the uttower
// swipe right and left to rotate the uttower
// then swipe up to unlock

class EnterPageViewController: UIViewController {

    // record the rotate deflection
    var flag = 0
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var towerImage: UIImageView!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var WelcomeLabel: UILabel!
    @IBOutlet weak var instruction: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add gesture recognizators
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(recognizeLeft(recognizer:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(recognizeRight(recognizer:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(recognizeUp(recognizer:)))
        upSwipe.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(upSwipe)

        // put the tower in a random rotate deflection each time
        var ran = Int.random(in: 1..<6)
        UIView.animate(
            withDuration: 1.0,
            animations: {
                // 180 degree rotation
                self.towerImage.transform =
                self.towerImage.transform.rotated(by: -CGFloat(Double.pi * Double(ran) / 3.0))
                }
        )
        self.flag -= ran
        
        // hide the start button unless solve the puzzle
        self.startButton.isEnabled = false
        self.startButton.alpha = 0.0
        self.appName.alpha = 0.0
        self.WelcomeLabel.alpha = 0.0
        instruction.numberOfLines = 0
    }
    
    // define three recognizers
    @IBAction func recognizeUp(recognizer: UISwipeGestureRecognizer)
    {
        if recognizer.state == .ended {
            view.translatesAutoresizingMaskIntoConstraints = true
        }
        if (self.flag % 6) == 0 {
            UIView.animate(
                withDuration: 3.0,
                animations: {
                self.towerImage.alpha = 0.0
                }
            )
            
            UIView.animate (
                withDuration: 2.0,
                animations: {
                    self.flagImage.alpha = 0.0
                }
            )
            
            self.startButton.isEnabled = true
            UIView.animate (
                withDuration: 1.0,
                animations: {
                    self.startButton.alpha = 1.0
                }
            )
            
            UIView.animate (
                withDuration: 1.0,
                animations: {
                    self.appName.alpha = 1.0
                }
            )
            
            UIView.animate (
                withDuration: 1.0,
                animations: {
                    self.instruction.alpha = 0.0
                }
            )
            
            UIView.animate (
                withDuration: 1.0,
                animations: {
                    self.WelcomeLabel.alpha = 1.0
                }
            )
            
        }
    }
    
    @IBAction func recognizeLeft(recognizer: UISwipeGestureRecognizer)
    {
        if recognizer.state == .ended {
            view.translatesAutoresizingMaskIntoConstraints = true
        }
        self.flag -= 1
        var durationValue = 1.0
        UIView.animate(
            withDuration: durationValue,
            animations: {
                self.towerImage.transform =
                self.towerImage.transform.rotated(by: -CGFloat(Double.pi/3.0))
                }
        )
        
    }
    
    @IBAction func recognizeRight(recognizer: UISwipeGestureRecognizer)
    {
        if recognizer.state == .ended {
            view.translatesAutoresizingMaskIntoConstraints = true
        }
        self.flag += 1
        var durationValue = 1.0
        UIView.animate(
            withDuration: durationValue,
            animations: {
                self.towerImage.transform =
                self.towerImage.transform.rotated(by: CGFloat(Double.pi/3.0))
                }
        )
        
    }
    
    
}
