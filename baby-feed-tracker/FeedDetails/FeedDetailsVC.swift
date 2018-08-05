//
//  FeedDetailsVC.swift
//  baby-feed-tracker
//
//  Created by Sha on 31/7/18.
//  Copyright © 2018 Sha. All rights reserved.
//

import UIKit
import CoreData

class FeedDetailsVC: UIViewController {
    
    private var fetchedRC: NSFetchedResultsController<Feed>!
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IB
    
    @IBAction func addFeed(_ sender: UIButton) {
        let feed = Feed.init(entity: Feed.entity(), insertInto: context)
        feed.startTime = NSDate()
        feed.amount = 70
        
        appDelegate.saveContext()
    }
    
    // MARK: - Private
    
    private func refresh() {
        let request = Feed.fetchRequest() as NSFetchRequest<Feed>
        let startTimeSort = NSSortDescriptor(key: #keyPath(Feed.startTime), ascending: true)
        request.sortDescriptors = [startTimeSort]
        do {
            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try fetchedRC.performFetch()
        } catch let error as NSError {
            print("Could not fetch. \(error) \(error.userInfo)");
        }
    }
}
