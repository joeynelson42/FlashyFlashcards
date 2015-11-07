//
//  CategoryPageViewController.swift
//  FlashyFlashcards
//
//  Created by Joey on 11/6/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class CategoryPageViewController: UIViewController{
    
    
    //MARK: STUDY OUTLETS
    @IBOutlet weak var animationContainer: UIView!
    @IBOutlet weak var row1: UIView!
    @IBOutlet weak var studyButton: UIView!
    @IBOutlet weak var cell1_3: UIView!
    @IBOutlet weak var cell2_2: UIView!
    @IBOutlet weak var cell2_1: UIView!
    
    var animationTimer = NSTimer()
    
    
    override func viewDidLoad() {
        animationContainer.layer.cornerRadius = 10.0
        
        animationContainer.layer.zPosition = CGFloat(MAXFLOAT)
        animate()
    }
    
    override func viewDidDisappear(animated: Bool) {
    }
    
    func animate(){
        UIView.animateWithDuration(0.8, delay: 0, options:[], animations: {
            self.row1.transform = CGAffineTransformMakeTranslation(-75, 0)
            }, completion: {finished in
        
                UIView.animateWithDuration(0.4, delay: 0.4, options:[], animations: {
        
                    self.cell1_3.backgroundColor = UIColor.fromHex(0x92D57F)
                    self.cell1_3.transform = CGAffineTransformMakeScale(0.8, 0.8)
                    }, completion: {finished in
                        
                        UIView.animateWithDuration(0.4, delay: 0.0, options:[], animations: {
                            self.studyButton.backgroundColor = UIColor.fromHex(0x92D57F)
                            self.cell1_3.transform = CGAffineTransformMakeScale(1.0, 1.0)
                            
                            }, completion: {finished in
                                
                                UIView.animateWithDuration(0.4, delay: 0.0, options:[], animations: {
                                    self.cell2_2.backgroundColor = UIColor.fromHex(0x92D57F)
                                    self.cell2_2.transform = CGAffineTransformMakeScale(0.8, 0.8)
                                    }, completion: {finished in
                                        
                                        UIView.animateWithDuration(0.4, delay: 0.0, options:[], animations: {
                                            self.cell2_2.transform = CGAffineTransformMakeScale(1.0, 1.0)
                                            }, completion: {finished in
                                        
                                                UIView.animateWithDuration(0.4, delay: 1.0, options:[], animations: {
                                            
                                                    self.studyButton.backgroundColor = UIColor.fromHex(0x979797)
                                                    self.cell1_3.backgroundColor = UIColor.whiteColor()
                                                    self.cell2_2.backgroundColor = UIColor.whiteColor()
                                                    self.row1.transform = CGAffineTransformMakeTranslation(0, 0)
                                                    self.startTimer()
                                                
                                                }, completion: nil)
                                        })
                                })
                        })
                })
        })
        
        
    }
    
    func startTimer(){
        self.animationTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "animate", userInfo: nil, repeats: false)
    }
    
    
    func resetView(){
        animationTimer.invalidate()
        UIView.animateWithDuration(0.1, delay: 0, options: .BeginFromCurrentState , animations: {
            self.studyButton.backgroundColor = UIColor.fromHex(0x979797)
            self.cell1_3.backgroundColor = UIColor.whiteColor()
            self.cell2_2.backgroundColor = UIColor.whiteColor()
            self.row1.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
    }
    
}