//
//  ViewController.swift
//  Assignment2New
//
//  Created by Oliver Lin on 19/9/18.
//  Copyright © 2018 Monash University. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import CoreData

protocol RaspioDelegate {
    func addRaspio(raspioObject: Raspio)
}

class FirstScreenTableViewController: UITableViewController {
    
    private var raspios : [Raspio] = []
    private var raspioRef: DatabaseReference?
    private var raspioRefHandle: DatabaseHandle?
    private var flowerList : [Flower] = []
    private var managedObjectContext: NSManagedObjectContext
    required init?(coder aDecoder: NSCoder) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = (appDelegate?.persistentContainer.viewContext)!
        super.init(coder: aDecoder)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        raspioRef = Database.database().reference().child("raspio")
        observeExistingRapiosData()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Flower")
        do{
            flowerList = try managedObjectContext.fetch(fetchRequest) as! [Flower]
        }
        catch {
            fatalError("Failded to fetch teams: \(error)")
        }
        //add the 5 flowers into coredata
        if flowerList.count == 0{
            let flowerName = ["China rose","Violet","Chrysanthemum","Orchid","Rhododendron "]
            let minTemp = [18,15,18,25,12]
            let maxTemp = [28,18,21,28,25]
            let lights = ["yes","yes","yes","no","no"]
            var flowerCount = 0
            while flowerCount < 5{
                let flower = NSEntityDescription.insertNewObject(forEntityName: "Flower", into: managedObjectContext)as! Flower
                flower.flowername = flowerName[flowerCount]
                flower.mintemp = Double(minTemp[flowerCount])
                flower.maxtemp = Double(maxTemp[flowerCount])
                flower.lights = lights[flowerCount]
                flowerCount += 1
                do{
                    try self.managedObjectContext.save()
                }
                catch let error{
                    print("could not save core data: \(error)")
                }
            }
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func observeNewRapiosData(){
        raspioRefHandle = raspioRef?.observe(.childAdded, with: {
            (snapshot) -> Void in
            let data = snapshot.value as! Dictionary<String, AnyObject>
            let id = data["data"] as! Int
            let red = data["red"] as! Double?
            let blue = data["blue"] as! Double?
            let green = data["green"] as! Double?
            let temp = data["temp"] as! Double?
            let pressure = data["pressure"] as! Double?
            let altimeter = data["altimeter"] as! Double?
            if let name = data["name"] as! String?, name.count > 0 {
                self.raspios.append(Raspio(id: id, name: name, red: red!,blue: blue!,green: green!,temp: temp!,pressure: pressure!, altimeter: altimeter!))
                // reload the table view if this is a table view ..
                //self.tableView.reloadData()
            } else {
                print ("error")
            }
        })
    }
    
    private func observeExistingRapiosData(){
        raspioRef?.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0{
                self.raspios.removeAll()
                for firebaseSensorData in snapshot.children.allObjects as! [DataSnapshot]{
                    let raspio = firebaseSensorData.value as! [String: AnyObject]
                    let id = raspio["data"] as! Int
                    let red = raspio["red"] as! Double
                    let blue = raspio["blue"] as! Double
                    let green = raspio["green"] as! Double
                    let temp = raspio["temp"] as! Double
                    let altimeter = raspio["altimeter"] as! Double
                    let name = raspio["name"] as! String
                    let pressure = raspio["pressure"] as! Double
                    // have to make sure that this object is not nil
                    if let name: String = name {
                        self.raspios.append(Raspio(id: id, name: name, red: red, blue: blue,green: green,temp: temp, pressure: pressure, altimeter: altimeter))
                    }
                }
                // if this is a tableView, reloadData...
                self.tableView.reloadData()
            }
        })
    }
    
    // the sections are considered as the number of entry in the firebase.
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // the number of rows in the tableview is the number of attributes one firebase entry...
    // the name attribute (tom&oliver) is not counted as an attribute
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return raspios.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RaspioAttribute", for: indexPath) as! FirstScreenTableViewCell
        //cell.attributeName.text = String(raspios[indexPath.row].id)
        cell.attributeName.text = Tool.convertUnixTimeToDate(timeIntervalSince1970: raspios[indexPath.row].id)
     
        // Configure the cell...
     
        return cell
     }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAllAttribute" {
            let indexPath = tableView.indexPath(for: sender as! FirstScreenTableViewCell)
            let destinationViewController = segue.destination as! RaspioEntryDetailTableViewController
            destinationViewController.addRaspio(raspioObject: raspios[(indexPath?.row)!])
            
        }
        
     }
 



}

