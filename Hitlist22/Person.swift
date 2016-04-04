//
//  Person.swift
//  Hitlist22
//
//  Created by Nikolay Botev on 4/4/16.
//  Copyright © 2016 Ubimoji. All rights reserved.
//

import CoreData

@objc(Person)
class Person: NSManagedObject {
    class func createIn(managedContext: NSManagedObjectContext) -> Person {
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)

        return NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext) as! Person
    }

    @NSManaged var name: String?
}
