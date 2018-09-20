//
//  RaspioEntryDetailTableViewController.swift
//  Assignment2New
//
//  Created by Oliver Lin on 19/9/18.
//  Copyright © 2018 Monash University. All rights reserved.
//

import UIKit

class RaspioEntryDetailTableViewController: UITableViewController, RaspioDelegate{
    
    var raspio: Raspio?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return 3
        }else{
            return 3
        }
    }
    
    func addRaspio(raspioObject: Raspio) {
        self.raspio = raspioObject
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RaspioEntryDetailCell", for: indexPath) as! RaspioEntryDetailTableViewCell
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.attributeNameLabel.text = "Red: "
                cell.attributeValueLabel.text = String(format:"%f", (raspio?.red)!)
            }
            if indexPath.row == 1 {
                cell.attributeNameLabel.text = "Green: "
                cell.attributeValueLabel.text = String(format:"%f", (raspio?.green)!)
            }
            if indexPath.row == 2 {
                cell.attributeNameLabel.text = "Blue: "
                cell.attributeValueLabel.text = String(format:"%f", (raspio?.blue)!)
            }
        }else{
            if indexPath.row == 0 {
                cell.attributeNameLabel.text = "Altimeter: "
                cell.attributeValueLabel.text = String(format:"%f", (raspio?.altimeter)!)
            }
            if indexPath.row == 1 {
                cell.attributeNameLabel.text = "Pressure: "
                cell.attributeValueLabel.text = String(format:"%f", (raspio?.pressure)!)
            }
            if indexPath.row == 2 {
                cell.attributeNameLabel.text = "temperature: "
                cell.attributeValueLabel.text = String(format:"%f", (raspio?.temp)!)
            }
        }

        return cell
    }
    
    // Asks the data source for the title of the header of the specified section of the table view
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "RGB Sensor" : "Temperature Sensor"
    }
    
    //Asks the delegate for the height to use for the footer of a particular section.
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
