//
//  FilterVC.swift
//  ThePlace2019
//
//  Created by Михаил Луцкий on 26.10.2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

protocol FilterDelegate: NSObject {
    func didFinishWithSelectedCategory(filters: FilterS, isHeatMap: Bool)
    func didFinishForClear()
}

struct FilterS {
    var emoji: String
    var title: String
    var json: String
}

class FilterVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var filters = [FilterS]()
    var isHeatMap = false
    
    weak var delegate: FilterDelegate?
    
    var selectedId = -1
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        // Do any additional setup after loading the view.
    }
    
    func setNewFilters(_ filters: [FilterS], title: String) {
        titleLabel.text = title
        selectedId = -1
        self.filters = filters
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filter = filters[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilterCell
        cell.emojiLabel.text = filter.emoji
        cell.descriptionLabel.text = filter.title
        cell.contentView.backgroundColor = .clear
        if selectedId == indexPath.row {
            cell.insideView.backgroundColor = .green
        } else {
            cell.insideView.backgroundColor = .clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if selectedId == indexPath.row {
            selectedId = -1
            if isHeatMap {
                delegate?.didFinishForClear()
            } else {
                StorageManager.shared.pinStructure = FilterS(emoji: "🏢", title: "Resedence", json: "")
            }
        } else {
            selectedId = indexPath.row
            if isHeatMap {
                delegate?.didFinishWithSelectedCategory(filters: filters[indexPath.row], isHeatMap: isHeatMap)
            } else {
                StorageManager.shared.pinStructure = filters[indexPath.row]
            }
        }
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {

        let totalCellWidth = 90 * filters.count
        let totalSpacingWidth = 16 * (filters.count - 1)

        let leftInset = (collectionView.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }


}
