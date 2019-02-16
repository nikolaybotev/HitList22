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

    var people = [Person]()

    @IBOutlet var tableView: UITableView!

    var managedContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        // 2
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")

        // 3
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    @IBAction func addName(_ sender: AnyObject) {
        let alert = UIAlertController(title: "New Name",
                                      message: "Addd a new name",
                                      preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Save", style: .default) { action in

            let textField = alert.textFields!.first
            self.addPerson(textField!.text!)
            self.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)  { action in
        }

        alert.addTextField { textField in
        }

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    func addPerson(_ name: String) {
        // 3
        let person = Person.createIn(managedContext)

        person.name = name

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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        cell!.textLabel!.text = people[(indexPath as NSIndexPath).row].name

        return cell!
    }
}

