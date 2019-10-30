//
//  SearchAddressVC.swift
//  ThePlace2019
//
//  Created by Михаил Луцкий on 26.10.2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

class SearchAddressVC: UITableViewController {
        
    @IBOutlet weak var searchBar: UISearchBar!
    
    let placeManager = PlaceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder()
        navigationItem.title = "Search"
        searchBar.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeManager.places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = placeManager.places[indexPath.row].address
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        placeManager.getCoordsOfPlaceId(placeManager.places[indexPath.row].placeId) { (coords) in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "getAddress"), object: nil, userInfo: ["coords":coords])
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension SearchAddressVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        placeManager.getAddressesForText(searchText) { (places) in
            self.tableView.reloadData()
        }
    }
}
