//
//  ViewController.swift
//  Nubee
//
//  Created by Lucas Farah on 1/20/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    print(readJSON())
  }
  
  //Returns Play by Play data
  func readJSON() -> Array<NSDictionary>
  {
    let path = NSBundle.mainBundle().pathForResource("potato", ofType: "json")
    let jsonData = NSData(contentsOfFile: path!)
    
    do
    {
      let jsonArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers)
      
      return jsonArray as! Array<NSDictionary>
    }
    catch{}
    
    return []
  }
  
}

