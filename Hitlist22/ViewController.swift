//
//  ViewController.swift
//  Hitlist22
//
//  Created by Nikolay Botev on 4/4/16.
//  Copyright © 2016 Ubimoji. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    var people = [NSManagedObject]()

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        // 1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        // 2
        let fetchRequest = NSFetchRequest(entityName: "Person")

        // 3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)

            people = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "New Name",
                                      message: "Addd a new name",
                                      preferredStyle: .Alert)

        let saveAction = UIAlertAction(title: "Save", style: .Default) { action in

            let textField = alert.textFields!.first
            self.addPerson(textField!.text!)
            self.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel)  { action in
        }

        alert.addTextFieldWithConfigurationHandler { textField in
        }

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        presentViewController(alert, animated: true, completion: nil)
    }

    func addPerson(name: String) {
        // 1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        // 2
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)

        // 3
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)

        person.setValue(name, forKey: "name")

        // 4
        do {
            try managedContext.save()

            // 5
            people.append(person)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")

        cell!.textLabel!.text = people[indexPath.row].valueForKey("name") as? String

        return cell!
    }
}

