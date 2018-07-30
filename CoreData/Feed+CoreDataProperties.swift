//
//  Feed+CoreDataProperties.swift
//  baby-feed-tracker
//
//  Created by Sha on 30/7/18.
//  Copyright © 2018 Sha. All rights reserved.
//
//

import Foundation
import CoreData


extension Feed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feed> {
        return NSFetchRequest<Feed>(entityName: "Feed")
    }

    @NSManaged public var startTime: NSDate?
    @NSManaged public var amount: Int16

}
