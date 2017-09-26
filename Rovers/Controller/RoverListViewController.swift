//
//  RoverListViewController.swift
//  Rovers
//
//  Created by Admin on 25/09/2017.
//  Copyright © 2017 pavbox. All rights reserved.
//

import UIKit

class RoverListViewController: UITableViewController {
    
    var roverCollection: roverDictionary = []
    
    
    @objc private func refresh() {
        let rover = Rover();
        rover.getRoverList() { (rovers) in
            self.roverCollection = rovers
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        
        refresh();
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (roverCollection.count > 0) ? roverCollection.count : 0;
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @IBAction func chooseSol(_ sender: UITextField) {
    }
    
    // custom cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RoverTableViewCell", for: indexPath) as? RoverTableViewCell else { fatalError("cant init cell") }

        if roverCollection.count < 1 { return cell }

        cell.RoverTitle.text       = roverCollection[indexPath[0]]["name"]! as? String
        cell.detailTextLabel?.text = roverCollection[indexPath[0]]["status"]! as? String
        
        let launchDate = roverCollection[indexPath[0]]["launch_date"]! as? String
        let lastActiveDate = roverCollection[indexPath[0]]["max_date"]! as? String
        
        cell.RoverLaunchDate.text     = "Launch Date: \(launchDate!)"
        cell.RoverLastActiveDate.text = "Last Active Date: \(lastActiveDate!)"

        return cell
    }

    
    // MARK: - Navigation
 
    var segueRover: roverItem?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as! RoverTableViewCell
        let indexOfCell = Int(String(describing: currentCell)) ?? 0
        
        segueRover = roverCollection[indexPath[indexOfCell]]
 
        self.performSegue(withIdentifier: "segue_roverDetail", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue_roverDetail" && segueRover != nil) {
            let RoverDetailController = segue.destination as! RoverDetailViewController
            RoverDetailController.segueRover = segueRover
        }
    }
}
