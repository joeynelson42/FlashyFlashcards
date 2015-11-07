//
//  StudyPageViewController.swift
//  FlashyFlashcards
//
//  Created by Joey on 11/6/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class StudyPageViewController: UIViewController{
    
    @IBOutlet weak var animationContainer: UIView!
    
    @IBOutlet weak var rightCard: UIView!
    @IBOutlet weak var centerCard: UIView!
    @IBOutlet weak var leftCard: UIView!
    
    @IBOutlet weak var rightCardEquation: UILabel!
    
    var animationTimer: NSTimer!
    
    
    override func viewDidLoad() {
        animationContainer.layer.cornerRadius = 10.0
    }
    
    override func viewDidAppear(animated: Bool) {
        animate()
    }
    
    func animate(){
        UIView.animateWithDuration(0.6, delay: 0.0, options:[], animations: {
            self.rightCard.transform = CGAffineTransformMakeTranslation(-250, 0)
            self.centerCard.transform = CGAffineTransformMakeTranslation(-250, 0)
            self.leftCard.transform = CGAffineTransformMakeTranslation(-250, 0)
            }, completion: {finished in
                
                UIView.animateWithDuration(0.6, delay: 3.0, options:[], animations: {
                    
                    UIView.transitionWithView(self.rightCard!, duration: 0.6, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { void in
                        self.rightCardEquation.text = "1"}, completion: {finished in
                    self.rightCardEquation.text = "1"
                    })
                    
                    }, completion: { finished in

                        UIView.animateWithDuration(0.6, delay: 1.0, options:[], animations: {
                            self.rightCard.transform = CGAffineTransformMakeTranslation(0, 0)
                            self.centerCard.transform = CGAffineTransformMakeTranslation(0, 0)
                            self.leftCard.transform = CGAffineTransformMakeTranslation(0, 0)
                            self.startTimer()
                            }, completion: {finished in
                                self.rightCardEquation.text = "3 - 2 = ?"
                        })
                })
        })
    }
    
    func startTimer(){
        self.animationTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "animate", userInfo: nil, repeats: false)
    }
    
    
}
