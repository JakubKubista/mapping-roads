//
//  Way+CoreDataProperties.swift
//  iOS Projekt
//
//  Created by student on 22/04/16.
//  Copyright © 2016 xkubist1. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

// Třída cesty a atributy pro její identifikaci.

import Foundation
import CoreData

extension Way {

    @NSManaged var doprava: String?
    @NSManaged var nazev: String?
    @NSManaged var teren: String?
    @NSManaged var location: NSData?

}
