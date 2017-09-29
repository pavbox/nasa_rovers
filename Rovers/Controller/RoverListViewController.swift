//
//  RoverListViewController.swift
//  Rovers
//
//  Created by Admin on 25/09/2017.
//  Copyright © 2017 pavbox. All rights reserved.
//

import UIKit

class RoverListViewController: UITableViewController {
    
    var roverCollection: [roverDictionary] = []
    
    @objc private func refresh() {
        let roverData = RoverData();
        roverData.getRoverList() { (rovers) in
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

    
    // custom cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RoverTableViewCell", for: indexPath) as? RoverTableViewCell else { fatalError("cant init cell") }

        if roverCollection.count < 1 { return cell }

        let currentRover = roverCollection[indexPath[0]];
        
        cell.RoverTitle.text       = currentRover["name"]! as? String
        cell.detailTextLabel?.text = currentRover["status"]! as? String
        
        let launchDate     = currentRover["launch_date"]! as? String
        let lastActiveDate = currentRover["max_date"]!    as? String
        
        cell.RoverLaunchDate.text     = "Launch Date: \(launchDate!)"
        cell.RoverLastActiveDate.text = "Last Active Date: \(lastActiveDate!)"

        return cell
    }

    
    // MARK: - Navigation
 
    var segueRover: roverDictionary?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!

        segueRover = roverCollection[indexPath[0]]
 
        self.performSegue(withIdentifier: "segue_roverDetail", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue_roverDetail" && segueRover != nil) {
            let RoverDetailController = segue.destination as! RoverDetailViewController
            RoverDetailController.segueRover = segueRover
        }
    }
}
