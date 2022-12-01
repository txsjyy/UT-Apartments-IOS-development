//
//  EnterPageViewController.swift
//  Project
//
//  Created by Junyu Yao on 11/30/22.
//

import UIKit

class EnterPageViewController: UIViewController {

    var flag = 0
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var towerImage: UIImageView!
    @IBOutlet weak var flagImage: UIImageView!
    
    @IBOutlet weak var instruction: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(recognizeLeft(recognizer:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(recognizeRight(recognizer:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(recognizeUp(recognizer:)))
        upSwipe.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(upSwipe)

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
        
        self.startButton.isEnabled = false
        self.startButton.alpha = 0.0
        self.appName.alpha = 0.0
        
        instruction.numberOfLines = 0
    }
    
    @IBAction func recognizeUp(recognizer: UISwipeGestureRecognizer)
    {
        if recognizer.state == .ended {
            view.translatesAutoresizingMaskIntoConstraints = true
        }
        if (self.flag % 6) == 0 {
            UIView.animate(
                withDuration: 3.0,
                animations: {
                    self.towerImage.center.y -= self.view.bounds.height
                }
            )
            
            self.flagImage.alpha = 1.0
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
                // 180 degree rotation
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
                // 180 degree rotation
                self.towerImage.transform =
                self.towerImage.transform.rotated(by: CGFloat(Double.pi/3.0))
                }
        )
        
    }
    
    
}
