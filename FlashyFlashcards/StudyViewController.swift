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
    
    override func viewDidLoad() {
        DeckManager.deckManager.constructEquations()
        deck = DeckManager.deckManager.deck
        deck.equations = shuffleCards()
        carousel.pagingEnabled = true
        
        xButton.layer.cornerRadius = 5.0
        xButton.backgroundColor = UIColor.fromHex(0x92D57F, alpha: 0.5)
    }
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {

        return deck.equations.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView
    {
        var label: UILabel
        var itemView: UIView
        
        //create new view if no view is available for recycling
        if (view == nil)
        {
            //don't do anything specific to the index within
            //this `if (view == nil) {...}` statement because the view will be
            //recycled and used with other index values later
            itemView = UIView(frame:CGRect(x:0, y:0, width:450, height:300))
            itemView.layer.cornerRadius = 3.0
            itemView.contentMode = .Center
            itemView.backgroundColor = UIColor.whiteColor()
            label = UILabel(frame:itemView.bounds)
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = .Center
            label.font = label.font.fontWithSize(80)
            label.tag = 1
            
            itemView.layer.cornerRadius = 3.0
            itemView.layer.shadowColor = UIColor.blackColor().CGColor
            itemView.layer.shadowOpacity = 0.2
            itemView.layer.shadowOffset = CGSizeMake(0, 10)
            itemView.layer.shadowRadius = 10.0
            itemView.layer.masksToBounds = false
            
            itemView.addSubview(label)
        }
        else
        {
            //get a reference to the label in the recycled view
            itemView = view! as UIView
            label = itemView.viewWithTag(1) as! UILabel!
        }

        let equation = deck.equations[index]
        label.text = "\(equation.firstValue) \(deck.getOpTypeString(index)) \(equation.secondValue) = ?"
        
        return itemView
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        if (option == .Spacing)
        {
            return value * 1.1
        }
        return value
    }
    
    func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int) {
        let cell = carousel.itemViewAtIndex(index)
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