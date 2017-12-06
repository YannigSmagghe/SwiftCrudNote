//
//  FullRes+CoreDataProperties.swift
//  ManotteCrudSingleView
//
//  Created by admin on 06/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import CoreData


extension FullRes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FullRes> {
        return NSFetchRequest<FullRes>(entityName: "FullRes")
    }

    @NSManaged public var imageData: NSData?
    @NSManaged public var thumbnail: Thumbnail?

}
