//
//  CategoryViewController.swift
//  FlashyFlashcards
//
//  Created by Joey on 11/5/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var startButton: UIButton!
    var categories = [String]()
    var difficultyLevels = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    var selectedTopics = [String]()
    
    override func viewDidLoad() {
        loadCategories()
        DeckManager.deckManager.observer = self
        buttonContainer.layer.cornerRadius = 3.0
        buttonContainer.layer.shadowColor = UIColor.whiteColor().CGColor
        buttonContainer.layer.shadowOpacity = 0.2
        buttonContainer.layer.shadowOffset = CGSizeMake(0, 10)
        buttonContainer.layer.shadowRadius = 10.0
        buttonContainer.layer.masksToBounds = false
    }
    
    override func viewWillAppear(animated: Bool) {
        buttonContainer.backgroundColor = UIColor.grayColor()
        resetButtonContainer()
        tableView.reloadData()
    }
    
    //MARK: TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCell
        cell.categoryLabel.text = categories[indexPath.row]
        cell.categoryLabel.layer.shadowColor = UIColor.blackColor().CGColor
        cell.categoryLabel.layer.shadowOpacity = 0.5
        cell.categoryLabel.layer.shadowOffset = CGSizeMake(0, 5)
        cell.categoryLabel.layer.shadowRadius = 10.0
        cell.categoryLabel.layer.masksToBounds = false
        
        cell.collectionView.reloadData()
        
        return cell
    }
    
    @IBAction func startButtonAction(sender: AnyObject) {
        
        if(DeckManager.deckManager.deck.topics.isEmpty){
            return
        }
        
        
        DeckManager.deckManager.constructEquations()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let studyVC = mainStoryboard.instantiateViewControllerWithIdentifier("studyVC") as! StudyViewController
        studyVC.deck = DeckManager.deckManager.deck
        
        animateStartButton()
        self.presentViewController(studyVC, animated: true, completion: nil)
        
        
        
    }
    
    private func animateStartButton(){
        UIView.animateWithDuration(0.1, delay: 0, options: .CurveLinear, animations: {
                self.startButton.transform = CGAffineTransformMakeScale(0.6, 0.6)
            }, completion: {(Bool) -> Void in
                UIView.animateWithDuration(0.1, delay: 0, options: .CurveLinear, animations: {
                    self.startButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }, completion: nil)
        })
    }
    
    private func extendButtonContainer(){
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: {
            self.buttonContainer.transform = CGAffineTransformMakeScale(1, 10)
            }, completion: nil)
    }
    
    private func resetButtonContainer(){
        self.buttonContainer.transform = CGAffineTransformMakeScale(1, 1)
    }
    
    
    private func loadCategories(){
        categories = ["Addition", "Subtraction", "Multiplication", "Division"]
    }
    
    
    
    @IBAction func openTutorialAction(sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tutorialVC = mainStoryboard.instantiateViewControllerWithIdentifier("tutorialVC")
        self.presentViewController(tutorialVC, animated: true, completion: nil)
    }
    
}





