//
//  WordListViewController.swift
//  Eng2Go
//
//  Created by Konstantin Kirillov on 12.10.2022.
//

import UIKit

class WordListViewController: UITableViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredWords = [Word]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    
    private var words = [Word(engName: "Dog", rusName: "Собачка"),
                         Word(engName: "Cat", rusName: "Кошечка"),
                         Word(engName: "Catch", rusName: "Ловить"),
                         Word(engName: "Category", rusName: "Категория"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search word..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? WordCardViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        var word: Word
        if isFiltering {
            word = filteredWords[indexPath.row]
        } else {
            word = words[indexPath.row]
        }
        destination.word = word
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
           return filteredWords.count
        } else {
           return words.count
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        var word: Word
        
        if isFiltering {
            word = filteredWords[indexPath.row]
        } else {
            word = words[indexPath.row]
        }
        
        content.text = word.engName
        content.secondaryText = word.rusName
        
        cell.contentConfiguration = content

        return cell
    }

}

extension WordListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filteredContentForSearchText(_ searchText: String) {
        filteredWords = words.filter({ (word: Word) -> Bool in
            return word.engName.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
