//
//  FirstViewController.swift
//  baby-feed-tracker
//
//  Created by Sha on 30/7/18.
//  Copyright © 2018 Sha. All rights reserved.
//

import UIKit
import CoreData

class FeedListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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

    // MARK: - Table view Delefates and DataSources
    
    extension FeedListVC: UITabBarDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell")
            let feed = fetchedRC.object(at: indexPath)
            cell?.textLabel?.text = "\(feed.startTime!)" 
            cell?.detailTextLabel?.text = String(feed.amount)
            return cell!
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard let sections = fetchedRC.sections, let objects = sections[section].objects else {
                return 0
            }
            
            return objects.count
        }
    }

