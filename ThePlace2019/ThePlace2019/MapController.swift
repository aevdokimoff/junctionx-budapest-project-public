//
//  MapController.swift
//  ThePlace2019
//
//  Created by Михаил Луцкий on 26.10.2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import ObjectMapper

protocol MapControllerDelegate: NSObject {
    func didTapOnMapObject(coords: CLLocationCoordinate2D)
}

class MapController: UIView {

    let kCONTENT_XIB_NAME = "MapController"
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    
    private var markers = [GMSMarker]()
    
    private var heatmapLayer: GMUHeatmapTileLayer!
    
    weak var delegate: MapControllerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        mapView.delegate = self
        
        heatmapLayer = GMUHeatmapTileLayer()
        heatmapLayer.radius = 100
        addHeatmap()
        
        let camera = GMSCameraPosition.camera(withLatitude: 47.495348, longitude: 19.046751, zoom: 11
        )
                   mapView.camera = camera
        heatmapLayer.map = mapView
        
        let db = Firestore.firestore()
//        db.collection("hackathon").document("data").setData(["coordinates" : "1234"])
        
        db.collection("hackathon").document("data").getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(getAddress(_:)), name: Notification.Name(rawValue: "getAddress"), object: nil)
//        contentView.layer.cornerRadius = 4.0
//        contentView.layer.borderWidth = 1.0
    }
    
    @objc func getAddress(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: CLLocationCoordinate2D], let coords = userInfo["coords"] {
            let camera = GMSCameraPosition.camera(withLatitude: coords.latitude, longitude: coords.longitude, zoom: 12)
            mapView.camera = camera
            
            let marker = GMSMarker(position: coords)
            marker.map = mapView
        }
    }
    
    func addHeatmap(resource: String = "air")  {
        
        AF.request("http://lwts.ru/\(resource).json").responseJSON { (response) in
            var list = [GMUWeightedLatLng]()
            let coords = Mapper<CoordsModel>().mapArray(JSONObject: response.value) ?? [CoordsModel]()
            for coord in coords {
                let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(coord.lat, coord.lng), intensity: 1.0)
                list.append(coords)
            }
            self.heatmapLayer.weightedData = list
            self.heatmapLayer.map = self.mapView
        }
//
//      var list = [GMUWeightedLatLng]()
//      do {
//        // Get the data: latitude/longitude positions of police stations.
//        if let path = Bundle.main.url(forResource: resource, withExtension: "json") {
//          let data = try Data(contentsOf: path)
//          let json = try JSONSerialization.jsonObject(with: data, options: [])
//          if let object = json as? [[String: Any]] {
//            for item in object {
//              let lat = item["lat"]
//              let lng = item["long"]
//              let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(lat as! CLLocationDegrees, lng as! CLLocationDegrees), intensity: 1.0)
//              list.append(coords)
//            }
//          } else {
//            print("Could not read the JSON.")
//          }
//        }
//      } catch {
//        print(error.localizedDescription)
//      }
//      // Add the latlngs to the heatmap layer.
//      heatmapLayer.weightedData = list
//        heatmapLayer.map = mapView

    }
    
    func addMarker(coords: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coords)
        marker.map = mapView
    }
    
    func clearAllMarkers() {
        for marker in markers {
            marker.map = nil
        }
        markers.removeAll()
    }
    
}

extension MapController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("tap on marker")
        delegate?.didTapOnMapObject(coords: marker.position)
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
    }
}
