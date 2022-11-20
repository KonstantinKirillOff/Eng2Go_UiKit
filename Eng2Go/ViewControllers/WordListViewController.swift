//
//  WordListViewController.swift
//  Eng2Go
//
//  Created by Konstantin Kirillov on 12.10.2022.
//

import UIKit

class WordListViewController: UITableViewController {
    
    var words = [Word(engName: "Dog", rusName: "Собачка"),
                 Word(engName: "Cat", rusName: "Кошечка")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? WordCardViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let word = words[indexPath.row]
        destination.word = word
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let word = words[indexPath.row]
        
        content.text = word.engName
        content.secondaryText = word.rusName
        
        cell.contentConfiguration = content

        return cell
    }

}
