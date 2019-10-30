//
//  DetailVC.swift
//  ThePlace2019
//
//  Created by Михаил Луцкий on 26.10.2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import LMGraphView
import SDWebImage
import Alamofire
import ObjectMapper
import MBProgressHUD

struct Emoji {
    var emoji: String
    var id: Int
}

class DetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var mainEmojiLabel: UILabel!
    @IBOutlet weak var titleMainLabel: UILabel!
//    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var lineGraphView: LMLineGraphView!
    @IBOutlet weak var finalPhotoView: UIImageView!
    @IBOutlet weak var mapViewImage: UIImageView!
    @IBOutlet weak var animalsInThisAreaLabel: UILabel!
    @IBOutlet weak var firstTextLabel: UILabel!
    @IBOutlet weak var secondTextLabel: UILabel!
    @IBOutlet weak var thirdTextLabel: UILabel!
    @IBOutlet weak var collectVC: UICollectionView!
    
    var coords: CLLocationCoordinate2D!
    
    var point: PointModel?
    
    var firstEmojies = [Emoji(emoji: "🦌", id: 0), Emoji(emoji: "🦜", id: 1), Emoji(emoji: "🐠", id: 2),Emoji(emoji: "🦌", id: 0), Emoji(emoji: "🦜", id: 1), Emoji(emoji: "🐠", id: 2),Emoji(emoji: "🦌", id: 0), Emoji(emoji: "🦜", id: 1), Emoji(emoji: "🐠", id: 2),Emoji(emoji: "🦌", id: 0), Emoji(emoji: "🦜", id: 1), Emoji(emoji: "🐠", id: 2),Emoji(emoji: "🦌", id: 0), Emoji(emoji: "🦜", id: 1), Emoji(emoji: "🐠", id: 2)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.view.backgroundColor = UIColor(hexString: "48B853", alpha: 1.0)

        title = "Your building"
        
        collectVC.delegate = self
        collectVC.dataSource = self
        
        animalsInThisAreaLabel.text = "🐠 🦜 🦌"
        collectVC.register(UINib(nibName: "PlaceCell", bundle: nil), forCellWithReuseIdentifier: "cell")
//        firstCollectionView.register(UINib(nibName: "EmojiCell", bundle: nil), forCellWithReuseIdentifier: "cell")
//        lastCollectionView.register(UINib(nibName: "EmojiCell", bundle: nil), forCellWithReuseIdentifier: "cell")
////
////        firstCollectionView.delegate = self
////        firstCollectionView.dataSource = self
//
//        lastCollectionView.delegate = self
//        lastCollectionView.dataSource = self
        
        setGraph()
        
        let img = GImageManager(latitude: coords.latitude, longitude: coords.longitude)
        finalPhotoView.sd_setImage(with: URL(string: img.makeString()), completed: nil)
        mapViewImage.sd_setImage(with: URL(string: img.makeMapImageLink()), completed: nil)
        
        mainEmojiLabel.text = StorageManager.shared.pinStructure.emoji
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AF.request("http://lwts.ru/points.json").responseJSON { (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
//            print(response.value)
            let points = Mapper<PointModel>().mapArray(JSONObject: response.value) ?? [PointModel]()
            let randomInt = Int.random(in: 0..<points.count)

            if points.indices.contains(randomInt){
                let first = points[randomInt]
                self.point = first
                self.animalsInThisAreaLabel.text = first.value.animals_ground
                self.firstTextLabel.text = first.value.restrictions_ground
                self.secondTextLabel.text = first.value.restrictions_sky
                self.thirdTextLabel.text = first.value.restrictions_water
                self.collectVC.reloadData()
            }
        }
        
        let right = UIBarButtonItem(image: UIImage(named:"star"), style: .done, target: self, action: #selector(addToFavorite))
        navigationItem.rightBarButtonItem = right
//         Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.view.backgroundColor = UIColor(hexString: "48B853", alpha: 1.0)

    }
    
    func setGraph() {
        lineGraphView.xAxisValues = [[1: "01"], [2: "02"], [3: "03"], [4: "04"], [5: "05"], [6: "06"]]
        lineGraphView.layout.xAxisLabelColor = UIColor(hexString: "042C5C", alpha: 1)
        lineGraphView.layout.xAxisGridHidden = false
        lineGraphView.layout.yAxisGridHidden = true
        lineGraphView.yAxisMaxValue = 3000
        lineGraphView.layout.yAxisZeroHidden = true
        lineGraphView.layout.yAxisSegmentCount = 3
        lineGraphView.layout.yAxisLabelColor = UIColor(hexString: "042C5C", alpha: 1)
        lineGraphView.layout.xAxisScrollableOnly = false
        lineGraphView.title = "Population"
//        lineGraphView.layout.xAxisMargin = -45
//        lineGraphView.layout.xAxisIntervalInPx = 900
        
        let plot = LMGraphPlot()
        plot.strokeColor = UIColor(hexString: "#FE6AAC", alpha: 1.0)
        plot.fillColor = UIColor(hexString: "FF7E8D", alpha: 0.25)
        plot.graphPointColor = UIColor(hexString: "FFFFFF", alpha: 0.65)
        plot.curveLine = true
        plot.strokeCircleAroundGraphPoint = false
        plot.graphPoints = [
            LMGraphPointMake(CGPoint(x: 1, y: 1984), "01", "47")!,
            LMGraphPointMake(CGPoint(x: 2, y: 2400), "02", "80")!,
            LMGraphPointMake(CGPoint(x: 3, y: 1800), "03", "20")!,
            LMGraphPointMake(CGPoint(x: 4, y: 1850), "04", "23")!,
            LMGraphPointMake(CGPoint(x: 5, y: 1400), "05", "90")!,
            LMGraphPointMake(CGPoint(x: 6, y: 2000), "06", "10")!
        ]
        
        lineGraphView.graphPlots = [plot]
    }
    
    @objc func addToFavorite() {
        let addresses = ["Budapest, Zrínyi utca, Hungary", "Budapest, Haller utca, Hungary", "Budapest, Izabella utca, Hungary", "Budapest, Paulay Ede utca, Hungary", "Budapest, Quell Rudolf utca, Hungary"]
        let randomInt = Int.random(in: 0..<addresses.count)
        CoreDataManager.addToFav(emoji: StorageManager.shared.pinStructure.emoji, title: StorageManager.shared.pinStructure.title, address: addresses[randomInt])
        let right = UIBarButtonItem(image: UIImage(named: "star-2"), style: .done, target: self, action: #selector(addToFavorite))
        navigationItem.rightBarButtonItem = right
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == firstCollectionView {
//
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let p = point, let value = p.value, let counts = value.to_build_here {
            return counts.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == firstCollectionView {
//            let firstI = firstEmojies[indexPath.row]
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmojiCell
//            cell.emojiLabel.text = firstI.emoji
//
//            return cell
//        } else
//            if collectionView == lastCollectionView {
        if let p = point, let value = p.value, let counts = value.to_build_here {
            let b = counts[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlaceCell
            cell.titleLabel.text = b.name
            cell.imageView.sd_setImage(with: URL(string: b.img), completed: nil)
            cell.priceLabel.text = "$\(b.value ?? 0) mln."
            return cell
        }
        return UICollectionViewCell()
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        if let p = point {
            if sender.selectedSegmentIndex == 0 {
                self.animalsInThisAreaLabel.text = p.value.animals_ground
            } else if sender.selectedSegmentIndex == 1 {
                self.animalsInThisAreaLabel.text = p.value.animals_sky
            } else if sender.selectedSegmentIndex == 2 {
                self.animalsInThisAreaLabel.text = p.value.animals_water
            }
        }
    }
    
}
