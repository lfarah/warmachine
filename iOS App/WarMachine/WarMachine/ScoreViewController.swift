//
//  ScoreViewController.swift
//  WarMachine
//
//  Created by Demir Yilmaz on 1/17/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class ScoreViewController: UIViewController {

    @IBOutlet weak var lblHomeScore: UILabel!
    @IBOutlet weak var lblAwayScore: UILabel!
    @IBOutlet weak var lbAwayScoreBox: UIView!
    @IBOutlet weak var lbHomeScoreBox: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let offset = CGSize(width: 5, height: 5)
        
        lbAwayScoreBox.addShadow(offset: offset, radius: 5, color: UIColor.grayColor(), opacity: 1)
        lbHomeScoreBox.addShadow(offset: offset, radius: 5, color: UIColor.grayColor(), opacity: 1)        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
