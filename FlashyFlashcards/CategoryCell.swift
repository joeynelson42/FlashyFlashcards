//
//  CategoryCell.swift
//  FlashyFlashcards
//
//  Created by Joey on 11/6/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class CategoryCell : UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryLabel: UILabel!
    var difficultyLevels = [String]()
    
    override func awakeFromNib() {
        loadDifficulties()
    }
    
    private func loadDifficulties(){
        difficultyLevels = ["Beginner", "Intermediate", "Expert", "Master"]
    }
}

extension CategoryCell : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return difficultyLevels.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("difficultyCell", forIndexPath: indexPath) as! DifficultyCell
        cell.layer.cornerRadius = 3.0
        cell.layer.shadowColor = UIColor.darkGrayColor().CGColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSizeMake(0, 10)
        cell.layer.shadowRadius = 10.0
        cell.layer.masksToBounds = false
        
        cell.difficulty = difficultyLevels[indexPath.row]
        cell.category = categoryLabel.text!
        cell.difficultyLabel.text = cell.difficulty
        
        if DeckManager.deckManager.deckContains(cell.category, difficulty: cell.difficulty){
            cell.backgroundColor = UIColor.fromHex(0x92D57F)
        }
        else{
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! DifficultyCell
        
        if DeckManager.deckManager.deckContains(cell.category, difficulty: cell.difficulty){
            DeckManager.deckManager.removeTopic(cell.category, difficulty: cell.difficulty)
            cell.backgroundColor = UIColor.whiteColor()
        }
        else{
            DeckManager.deckManager.addTopic(cell.category, difficulty: cell.difficulty)
            cell.backgroundColor = UIColor.fromHex(0x92D57F)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! DifficultyCell
        
        if DeckManager.deckManager.deckContains(cell.category, difficulty: cell.difficulty){
            DeckManager.deckManager.removeTopic(cell.category, difficulty: cell.difficulty)
            cell.backgroundColor = UIColor.whiteColor()
        }
        else{
            DeckManager.deckManager.addTopic(cell.category, difficulty: cell.difficulty)
            cell.backgroundColor = UIColor.fromHex(0x92D57F)
        }
    }
}

extension CategoryCell : UICollectionViewDelegateFlowLayout {
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let itemsPerRow:CGFloat = 4
//        let hardCodedPadding:CGFloat = 5
//        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
//        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
//        return CGSize(width: itemWidth, height: itemHeight)
//    }
    
}