//
//  Person.swift
//  Hitlist22
//
//  Created by Nikolay Botev on 4/4/16.
//  Copyright © 2016 Ubimoji. All rights reserved.
//

import CoreData

class Person: NSManagedObject {
    class func createIn(_ managedContext: NSManagedObjectContext) -> Person {
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)

        return NSManagedObject(entity: entity!, insertInto: managedContext) as! Person
    }

    @NSManaged var name: String?
}
