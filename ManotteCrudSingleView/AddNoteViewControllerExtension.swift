//
//  Note+CoreDataProperties.swift
//  ManotteCrudSingleView
//
//  Created by admin on 06/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import CoreData


extension AddNoteViewController {

    // Extensions inutile car je n'ai pas réussi à sauvegarder l'image dans le core data, mais comme j'ai appris les extensions je laisse quand même
    @NSManaged public var titre: String?
    @NSManaged public var lieu: String?
    @NSManaged public var image: String?
    
}
