//
//  Team.swift
//  WarMachine
//
//  Created by Lucas Farah on 1/17/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class Team: UIViewController,UITableViewDataSource {
  var arrayPlayers = ["JULIAN EDELMAN - WIDE RECEIVER","SCOTT CHANDLER - TIGHT END","ALAN BRANCH - DEFENSIVE LINE","STEVEN JACKSON - RUNNING BACK","DANNY AMENDOLA - WIDE RECEIVER"]
  @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return arrayPlayers.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TableViewCell!
    if !(cell != nil)
    {
      cell = TableViewCell(style:.Default, reuseIdentifier: "cell")
    }
    // setup cell without force unwrapping it
    cell.lblName.text = arrayPlayers[indexPath.row]
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
