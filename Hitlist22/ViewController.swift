//
//  ViewController.swift
//  Hitlist22
//
//  Created by Nikolay Botev on 4/4/16.
//  Copyright © 2016 Ubimoji. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var names = [String]()

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "New Name",
                                      message: "Addd a new name",
                                      preferredStyle: .Alert)

        let saveAction = UIAlertAction(title: "Save", style: .Default) { action in

            let textField = alert.textFields!.first
            self.names.append(textField!.text!)
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

    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")

        cell!.textLabel!.text = names[indexPath.row]

        return cell!
    }
}

