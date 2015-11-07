//
//  DeckManager.swift
//  FlashyFlashcards
//
//  Created by Joey on 11/6/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class DeckManager{
    
    static let deckManager = DeckManager()
    
    var observer = CategoryViewController()
    var deck = Deck()
    
    func emptyDeck(){
        deck.topics.removeAll()
        deck.equations.removeAll()
    }
    
    //creates the equations and adds them to the deck
    func constructEquations(){
        for (topic, difficulties) in deck.topics{
            switch topic{
            case "Addition":
                constructAdditionEquations(difficulties)
                break
            case "Subtraction":
                constructSubtractionEquations(difficulties)
                break
            case "Multiplication":
                constructMultiplicationEquations(difficulties)
                break
            case "Division":
                constructDivisionEquations(difficulties)
                break
            default:
                break
            }
        }
    }
    
    func addTopic(category: String, difficulty: String){
        if(deck.topics.isEmpty){
            observer.buttonContainer.backgroundColor = UIColor.fromHex(0x92D57F)
        }
        
        if let _ = deck.topics[category] {
            deck.topics[category]?.append(difficulty)
        }
        else{
            deck.topics[category] = [difficulty]
        }
    }
    
    func removeTopic(category: String, difficulty: String){
        guard let _ = deck.topics[category] else{
            return
        }
        
        if(deck.topics[category]?.contains(difficulty) == true){
            for (i, diff) in deck.topics[category]!.enumerate(){
                if diff == difficulty{
                    deck.topics[category]?.removeAtIndex(i)
                    if(deck.topics[category]!.isEmpty){
                        deck.topics.removeValueForKey(category)
                    }
                }
            }
        }
        
        if(deck.topics.isEmpty){
            observer.buttonContainer.backgroundColor = UIColor.grayColor()
        }
    }
    
    func deckContains(category: String, difficulty: String) -> Bool{
        
        if(deck.topics[category] == nil){
            return false
        }
        else if (deck.topics[category]?.contains(difficulty) == false){
            return false
        }
        else{
            return true
        }
    }
    
    func constructAdditionEquations(difficulties: [String]){
        for level in difficulties{
            let range = findRange(level) //equations will use number 0-range
            for _ in 0...20{
                
                let firstValue = Int(arc4random_uniform(UInt32(range)) + 1)
                let secondValue = Int(arc4random_uniform(UInt32(range)) + 1)
                let answer = firstValue + secondValue
                
                let equation = Equation.init(opType: OperationType.Addition, firstValue: firstValue, secondValue: secondValue, answer: answer)
                
                deck.equations.append(equation)
            }
        }
    }
    
    func constructSubtractionEquations(difficulties: [String]){
        for level in difficulties{
            let range = findRange(level) //equations will use number 0-range
            for _ in 0...20{
                
                let firstValue = Int(arc4random_uniform(UInt32(range)) + 2)
                let secondValue = Int(arc4random_uniform(UInt32(firstValue - 1)) + 1)
                let answer = firstValue - secondValue
                
                let equation = Equation.init(opType: OperationType.Subtraction, firstValue: firstValue, secondValue: secondValue, answer: answer)
                
                deck.equations.append(equation)
            }
        }
    }
    
    func constructMultiplicationEquations(difficulties: [String]){
        for level in difficulties{
            let range = findRange(level) //equations will use number 0-range
            for _ in 0...20{
                
                let firstValue = Int(arc4random_uniform(UInt32(range)) + 1)
                let secondValue = Int(arc4random_uniform(UInt32(range)) + 1)
                let answer = firstValue * secondValue
                
                let equation = Equation.init(opType: OperationType.Multiplication, firstValue: firstValue, secondValue: secondValue, answer: answer)
                
                deck.equations.append(equation)
            }
        }
    }
    
    func constructDivisionEquations(difficulties: [String]){
        for level in difficulties{
            let range = findRange(level) //equations will use number 0-range
            for _ in 0...20{
                
                let firstValue = Int(arc4random_uniform(UInt32(range)) + 1)
                let secondValue = Int(arc4random_uniform(UInt32(range)) + 1)
                let answer = firstValue / secondValue
                
                let equation = Equation.init(opType: OperationType.Division, firstValue: firstValue, secondValue: secondValue, answer: answer)
                
                deck.equations.append(equation)
            }
        }
    }
    
    func findRange(difficulty: String) -> Int{
        var range = 10
        
        switch difficulty{
        case "Beginner":
            range = 10
            break
        case "Intermediate":
            range = 20
            break
        case "Expert":
            range = 50
            break
        case "Master":
            range = 100
            break
        default:
            break
        }
        return range
    }
}