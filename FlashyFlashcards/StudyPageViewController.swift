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
    @IBOutlet weak var startButton: UIButton!
    
    var animationTimer = NSTimer()
    var animationStarted = false
    
    override func viewDidLoad() {
        self.rightCard.backgroundColor = UIColor.clearColor()
        self.rightCardEquation.backgroundColor = UIColor.whiteColor()
        
        self.startButton.layer.cornerRadius = 20.0
        
//        self.rightCardEquation.layer.cornerRadius = 5.0
//        self.rightCard.layer.cornerRadius = 5.0
//        self.leftCard.layer.cornerRadius = 5.0
//        self.centerCard.layer.cornerRadius = 5.0
        
        animationContainer.layer.cornerRadius = 10.0
    }
    
    override func viewDidAppear(animated: Bool) {
        if !animationStarted{
            var _ = NSTimer.scheduledTimerWithTimeInterval(0.7, target: self, selector: "animate", userInfo: nil, repeats: false)
            animationStarted = true
        }
        showButton()
    }
    
    override func viewDidDisappear(animated: Bool) {
        hideButton()
    }
    
    func animate(){
        UIView.animateWithDuration(0.6, delay: 0.0, options:[], animations: {
            self.rightCard.transform = CGAffineTransformMakeTranslation(-250, 0)
            self.centerCard.transform = CGAffineTransformMakeTranslation(-250, 0)
            self.leftCard.transform = CGAffineTransformMakeTranslation(-250, 0)
            }, completion: {finished in
                
                UIView.animateWithDuration(0.2, delay: 0, options:[], animations: {
                    self.rightCardEquation.transform = CGAffineTransformMakeScale(0.9, 0.9)
                    //self.rightCardEquation.backgroundColor = UIColor.fromHex(0x92D57F)
                    
                    }, completion: {finished in
    
                        UIView.animateWithDuration(0.2, animations: {
                            self.rightCardEquation.transform = CGAffineTransformMakeScale(1.0, 1.0)
                            self.rightCardEquation.backgroundColor = UIColor.whiteColor()
                            }, completion: { finished in
                                
                                UIView.transitionWithView(self.rightCard!, duration: 0.6, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { void in
                                    self.rightCardEquation.text = "1"}, completion: {finished in
                                        self.rightCardEquation.text = "1"
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
                })
        })
    }
    
    func startTimer(){
        self.animationTimer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: "animate", userInfo: nil, repeats: false)
    }
    
    
    func showButton(){
        self.startButton.transform = CGAffineTransformMakeTranslation(0, 40)
        UIView.animateWithDuration(0.3, delay: 0, options: [], animations: {
                self.startButton.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.2, 1.2), CGAffineTransformMakeTranslation(0, 0))
            
                self.startButton.alpha = 1.0
            
            }, completion: {finished in
        
                UIView.animateWithDuration(0.3, animations: {
                    self.startButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                })
        })
    }
    
    func hideButton(){
        self.startButton.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 1.0), CGAffineTransformMakeTranslation(0, 0))
        self.startButton.alpha = 0.0
    }
    
    @IBAction func startButtonAction(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var viewed = defaults.boolForKey("tutorialViewed")
        
        defaults.setBool(true, forKey: "tutorialViewed")
        
        
        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: {
            self.startButton.transform = CGAffineTransformMakeScale(0.8, 0.8)
            
            }, completion: {finished in
                UIView.animateWithDuration(0.3, delay: 0, options: [], animations: {
                    self.startButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }, completion: {finished in
                        
                        if viewed{
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                        else{
                            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("categoryVC")
                            self.presentViewController(vc, animated: true, completion: nil)
                        }
                        
                })
        })
    }
}
