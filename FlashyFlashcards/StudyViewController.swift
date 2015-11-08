//
//  StudyViewController.swift
//  FlashyFlashcards
//
//  Created by Joey on 11/6/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit


class StudyViewController: UIViewController, iCarouselDataSource, iCarouselDelegate{
    
    var deck: Deck!
    @IBOutlet weak var carousel: iCarousel!
    @IBOutlet weak var xButton: UIButton!

    @IBOutlet weak var loadViewContainer: UIView!
    @IBOutlet weak var loadLightning: UIImageView!
    
    var CARD_WIDTH: CGFloat = 0
    var CARD_HEIGHT: CGFloat = 0
    
    var shouldRotate = false
    
    override func viewDidLoad() {
        DeckManager.deckManager.constructEquations()
        deck = DeckManager.deckManager.deck
        deck.equations = shuffleCards()
        carousel.pagingEnabled = true
        
        xButton.layer.cornerRadius = 5.0
        xButton.backgroundColor = UIColor.fromHex(0x92D57F, alpha: 0.5)
        
        if UIApplication.sharedApplication().statusBarOrientation == .Portrait || UIApplication.sharedApplication().statusBarOrientation == .PortraitUpsideDown{
            shouldRotate = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if shouldRotate{
            let value = UIInterfaceOrientation.LandscapeLeft.rawValue
            UIDevice.currentDevice().setValue(value, forKey: "orientation")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if shouldRotate{
            let value = UIInterfaceOrientation.Portrait.rawValue
            UIDevice.currentDevice().setValue(value, forKey: "orientation")
        }
        
        animateLoadLightning()
    }
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {

        return deck.equations.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView
    {
        var itemView: CarouselCell
        
        //create new view if no view is available for recycling
        if (view == nil)
        {
            //don't do anything specific to the index within
            //this `if (view == nil) {...}` statement because the view will be
            //recycled and used with other index values later
            getCarouselCellSize()
            itemView = CarouselCell(frame:CGRect(x:0, y:0, width:CARD_WIDTH, height:CARD_HEIGHT))
            itemView.layer.cornerRadius = 3.0
            itemView.contentMode = .Center
            itemView.backgroundColor = UIColor.whiteColor()
            itemView.label = UILabel(frame:itemView.bounds)
            itemView.label.backgroundColor = UIColor.clearColor()
            itemView.label.textAlignment = .Center
            itemView.label.font = itemView.label.font.fontWithSize(80)
            itemView.label.tag = 1
            itemView.label.adjustsFontSizeToFitWidth = true
            itemView.flipped = false
            
            itemView.layer.cornerRadius = 3.0
            itemView.layer.shadowColor = UIColor.blackColor().CGColor
            itemView.layer.shadowOpacity = 0.2
            itemView.layer.shadowOffset = CGSizeMake(0, 10)
            itemView.layer.shadowRadius = 10.0
            itemView.layer.masksToBounds = false
            
            itemView.addSubview(itemView.label)
        }
        else
        {
            //get a reference to the label in the recycled view
            itemView = view! as! CarouselCell
            itemView.label = itemView.viewWithTag(1) as! UILabel!
            itemView.flipped = false
        }

        let equation = deck.equations[index]
        itemView.label.text = "\(equation.firstValue) \(deck.getOpTypeString(index)) \(equation.secondValue) = ?"
        
        return itemView
    }
    
    func getCarouselCellSize(){
        if(UIScreen.mainScreen().bounds.height > UIScreen.mainScreen().bounds.width){
            CARD_WIDTH = UIScreen.mainScreen().bounds.width - 50
            CARD_HEIGHT = UIScreen.mainScreen().bounds.height - 250
        }
        else{
            CARD_WIDTH = UIScreen.mainScreen().bounds.width - 200
            CARD_HEIGHT = UIScreen.mainScreen().bounds.height - 50
        }
        
        
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        if (option == .Spacing)
        {
            return value * 1.1
        }
        return value
    }
    
//    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
//        carousel.reloadData()
//    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        carousel.reloadData()
        carousel.layoutSubviews()
    }
    
    func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int) {
        let cell = carousel.itemViewAtIndex(index) as! CarouselCell
        let equation = deck.equations[index]
        var updatedLabelText = ""
        if(cell.flipped){
            updatedLabelText = "\(equation.firstValue) \(deck.getOpTypeString(index)) \(equation.secondValue) = ?"
        }
        else{
            updatedLabelText = String(equation.answer)
        }
        
        
        UIView.transitionWithView(cell, duration: 0.4, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { void in
            cell.label.text = "\(updatedLabelText)"}, completion: { finished in
        cell.label.text = "\(updatedLabelText)"
        
        })
        
        
        cell.flipped = !cell.flipped
        
    }
    
    @IBAction func returnButtonAction(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: {
            
            self.xButton.transform = CGAffineTransformMakeScale(0.8, 0.8)
            }, completion: {finished in
                UIView.animateWithDuration(0.1, animations: {
                    self.xButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }, completion: {finished in
                        DeckManager.deckManager.emptyDeck()
                        self.dismissViewControllerAnimated(true, completion: nil)
                })
        })
    }
    
    private func animateLoadLightning(){
        let animationTimer = NSTimer.scheduledTimerWithTimeInterval(1.2, target: self, selector: "hideLoadScreen", userInfo: nil, repeats: false)
        
        UIView.animateWithDuration(0.4, delay: 0, options: [.Repeat, .Autoreverse], animations: {
                self.loadLightning.transform = CGAffineTransformMakeScale(0.8, 0.8)
            }, completion: nil)
    }
    
    func hideLoadScreen(){
        UIView.animateWithDuration(0.5, delay: 0, options: .BeginFromCurrentState, animations: {self.loadViewContainer.alpha = 0.0}, completion: nil)
    }
    
    private func shuffleCards() -> [Equation]{
        var shuffled = deck.equations
        for i in 0..<shuffled.count - 1 {
            let j = Int(arc4random_uniform(UInt32(shuffled.count - i))) + i
            guard i != j else { continue }
            swap(&shuffled[i], &shuffled[j])
        }
        return shuffled
    }
}