//
//  AppNamePageViewController.swift
//  FlashyFlashcards
//
//  Created by Joey on 11/6/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class AppNamePageViewController: UIViewController{
    
    @IBOutlet weak var seeHowLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    var pageController = UIPageViewController()
    var animationTimer = NSTimer()
    
    override func viewDidLoad() {
        
        var _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "animate", userInfo: nil, repeats: false)
    }
    
    func animate(){
        UIView.animateWithDuration(0.3, delay: 0, options: [], animations: {
            //self.seeHowLabel.transform = CGAffineTransformMakeScale(1.15, 1.15)
            self.arrowImageView.transform = CGAffineTransformMakeScale(1.15, 1.15)
            }, completion: {finished in
                UIView.animateWithDuration(0.3, animations: {
                    self.arrowImageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    //self.seeHowLabel.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }, completion: {finished in
                    self.startTimer()
                })
        })
    }
    
    func startTimer(){
        self.animationTimer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector: "animate", userInfo: nil, repeats: false)
    }
    
}