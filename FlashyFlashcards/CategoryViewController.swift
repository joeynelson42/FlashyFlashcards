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
    
    var categories = [String]()
    var difficultyLevels = [String]()
    
    override func viewDidLoad() {
        loadCategories()
        loadDifficulties()
    }
    
    //MARK: TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath)
        return cell
    }
    
    
    private func loadCategories(){
        categories = ["Addition", "Subtraction", "Multiplication", "Division"]
    }
    
    private func loadDifficulties(){
        difficultyLevels = ["Beginner", "Intermediate", "Expert", "Master"]
    }
    
}