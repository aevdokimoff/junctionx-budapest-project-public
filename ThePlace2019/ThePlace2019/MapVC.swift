//
//  MapVC.swift
//  ThePlace2019
//
//  Created by Михаил Луцкий on 26.10.2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import FloatingPanel
import Alamofire
import ObjectMapper

class MapVC: UIViewController, MapControllerDelegate, FloatingPanelControllerDelegate, FilterDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var fpc: FloatingPanelController!
    
    var contentVC: FilterVC!

    @IBOutlet weak var mapView: MapController!
    override func viewDidLoad() {
        super.viewDidLoad()

        contentVC = self.storyboard?.instantiateViewController(withIdentifier: "FilterVC") as? FilterVC

        mapView.delegate = self
        
        fpc = FloatingPanelController()
        fpc.surfaceView.backgroundColor = .clear
        fpc.surfaceView.cornerRadius = 9.0
        fpc.surfaceView.shadowHidden = false
//        fpc.surfaceView.grabberHandle.isHidden = true
        // Assign self as the delegate of the controller.
        fpc.delegate = self // Optional
        
        // Set a content view controller.
        contentVC.delegate = self
        fpc.set(contentViewController: contentVC)
        fpc.isRemovalInteractionEnabled = true // Optional: Let it removable by a swipe-down
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func openSearch(_ sender: Any) {
        fpc.dismiss(animated: true, completion: nil)

        let searchAddress = SearchAddressVC()
        self.present(searchAddress, animated: true, completion: nil)
    }
    
    @IBAction func plusAction(_ sender: Any) {
    }
    
    @IBAction func minusAction(_ sender: Any) {
    }
    
    @IBAction func myLocation(_ sender: Any) {
    }

    func didTapOnMapObject(coords: CLLocationCoordinate2D) {
        fpc.dismiss(animated: true, completion: nil)
        let vc = DetailVC()
        vc.coords = coords
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
//        self.present(vc, animated: true, completion: nil)
    }

    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return FilterLayout()
    }
    
    @IBAction func typeMapSelect(_ sender: UIButton) {
        fpc.dismiss(animated: true, completion: nil)
//        sender.isUserInteractionEnabled = false
        contentVC.isHeatMap = true
        contentVC.setNewFilters([FilterS(emoji: "🌊", title: "Aquatic", json: "water"), FilterS(emoji: "🏕", title: "Terrestrial", json: "forest"), FilterS(emoji: "🌦", title: "Aerial", json: "air")], title: "Select map habitat")
        self.present(fpc, animated: true, completion: nil)
    }
    
    @IBAction func typeAnimalSelect(_ sender: Any) {
    }
    
    @IBAction func typeConstructionSelect(_ sender: Any) {
         fpc.dismiss(animated: true, completion: nil)
        //        sender.isUserInteractionEnabled = false
        contentVC.isHeatMap = false
        contentVC.setNewFilters([
            FilterS(emoji: "🏢", title: "Resedence", json: "water"),
            FilterS(emoji: "🏠", title: "House", json: "forest"),
            FilterS(emoji: "🏘", title: "Houses", json: "forest"),
            FilterS(emoji: "🛤", title: "Railway", json: "forest"),
            FilterS(emoji: "⛽️", title: "Gas station", json: "forest"),
            FilterS(emoji: "🛫", title: "Airport", json: "forest"),
            FilterS(emoji: "🏭", title: "Factory", json: "forest"),
            FilterS(emoji: "🌉", title: "Bridge", json: "forest"),
            FilterS(emoji: "🎡", title: "Ferris Wheel", json: "air")
            ]
            , title: "Select map habitat")
        self.present(fpc, animated: true, completion: nil)
    }
    
    func didFinishWithSelectedCategory(filters: FilterS, isHeatMap: Bool) {
        if isHeatMap {
            mapView.mapView.clear()
            mapView.addHeatmap(resource: filters.json)
        }
    }
    
    func didFinishForClear() {
        mapView.mapView.clear()
        
    }
    
    @IBAction func clickOnCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // Save tag of image view we selected
            
            // Setup and present default Camera View Controller
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Dismiss the view controller a
        picker.dismiss(animated: true, completion: nil)
        
        // Get the picture we took
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let imageData = image.jpegData(compressionQuality: 0.8) ?? Data()

        print(imageData)

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "file", fileName: "file")
        }, to: "http://lwts.ru:8976/upload")
            .responseJSON { response in
                let array = Mapper<VisionModel>().mapArray(JSONObject: response.value)
                if let first = array?.first {
                    let alert = UIAlertController(title: "Congratulations!", message: "You loaded \(first.description ?? "")", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                debugPrint(response)
            }
    
    }
}
