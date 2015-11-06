//
//  Deck.swift
//  FlashyFlashcards
//
//  Created by Joey on 11/6/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

struct Equation{
    var opType: OperationType
    var firstValue: Int!
    var secondValue: Int!
}

enum OperationType{
    case Addition, Subtraction, Multiplication, Division
}

class Deck{
    var equations = [Equation]()
    var topics = [String: [String] ]()
    
    init(){
    
    }
    
    init(studyTopics: [String: [String] ]){
        topics = studyTopics
    }
    
    func getOpTypeString(index: Int) -> String{
        switch self.equations[index].opType{
        case .Addition:
            return "+"
        case .Subtraction:
            return "-"
        case .Multiplication:
            return "✕"
        case .Division:
            return "÷"
        }
    }

}