//
//  FlashcardView.swift
//  FlashyFlashcards
//
//  Created by Joey on 11/6/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class FlashcardView: UIView{
    
    @IBOutlet weak var equationLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "Flashcard", bundle: NSBundle.mainBundle()).instantiateWithOwner(nil, options: nil)[0] as! FlashcardView
    }
}