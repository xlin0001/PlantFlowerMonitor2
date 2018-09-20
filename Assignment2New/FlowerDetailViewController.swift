//
//  FlowerDetailViewController.swift
//  Assignment2New
//
//  Created by 沈宇帆 on 2018/9/20.
//  Copyright © 2018年 Monash University. All rights reserved.
//

import UIKit
import MapKit

class FlowerDetailViewController: UIViewController,CLLocationManagerDelegate {
    var fName: String?
    var lights: String?
    var latitudeText:String?
    var longitudeText:String?
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    var main: [String:Any]?
    var temp: String?
    var mintemp : Double?
    var maxtemp : Double?
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var lighetLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flowerImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        switch fName {
        case "China rose":
            self.flowerImage?.image = #imageLiteral(resourceName: "chinarose")
        case "Violet":
            self.flowerImage?.image = #imageLiteral(resourceName: "violet")
        case "Chrysanthemum":
            self.flowerImage?.image = #imageLiteral(resourceName: "Chrysanthemum")
        case "Orchid":
            self.flowerImage?.image = #imageLiteral(resourceName: "orchid")
        case "Rhododendron":
            self.flowerImage?.image = #imageLiteral(resourceName: "rhododendron")
        default:
            self.flowerImage?.image = #imageLiteral(resourceName: "chinarose")
        }
        nameLabel.text = "Flower Name: \(fName!)"
        lighetLabel.text = "heliophilous: \(lights!)"
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        self.getTemp()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager (_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]){
        let loc: CLLocation = locations.last!
        currentLocation = loc.coordinate
        self.latitudeText = "\(currentLocation!.latitude)"
        self.longitudeText = "\(currentLocation!.longitude)"
    }
    //273.15
    func getTemp(){
        let url =  "http://api.openweathermap.org/data/2.5/weather?"
        
        let location = "lat=\(latitudeText ?? "-37")&lon=\(longitudeText ?? "145")"
        let appid = "&appid=a8952275f286030ed34fc9e799c36fd2"
        let callUrl = URL(string: url + location + appid)
        let task = URLSession.shared.dataTask(with: callUrl!) { data, response,
            error in
            if(error != nil) {
                print("URL Error has occured: \(String(describing: error))")
            } else {
                self.parseJSON(jsonString: data!)
                DispatchQueue.main.async {
                    self.tempLabel.text = "current temperature: \(self.temp!)"
                }
            } }
        task.resume()
    }
    
    func parseJSON(jsonString: Data)   {
        do {
            let result = try JSONSerialization.jsonObject(with: jsonString, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
            self.main = (result["main"] as! [String:Any])
            self.temp = String(describing: main!["temp"])
        }
        catch let error as NSError {
            print("JSON Serialization ERROR: \(error)") }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
