//
//  TeamSelectViewController.swift
//  WarMachine
//
//  Created by Lucas Farah on 1/17/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import EZSwiftExtensions
class TeamSelectViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    self.createPickTeamView()
    
    
  }
  
  func createPickTeamView() {
    let image = UIImage(named: "pickteam-1.png")
    var imageView = UIImageView(image: image!)
    imageView.frame = CGRect(x: 0, y: 0, width: ez.screenWidth, height: ez.screenHeight)
    self.view.addSubview(imageView)
    
    let teamOneImageView = UIView(x: 0, y: 0, w: ez.screenWidth, h: ez.screenHeight/2 + 40)
    teamOneImageView.backgroundColor = UIColor.clearColor()
    self.view.addSubview(teamOneImageView)
    
    let teamTwoImageView = UIView(x: 0, y: ez.screenHeight/2 + 40, w: ez.screenWidth, h: ez.screenHeight/2)
    teamTwoImageView.backgroundColor = UIColor.clearColor()
    self.view.addSubview(teamTwoImageView)
    
    teamOneImageView.addTapGesture(tapNumber: 1) { (UITapGestureRecognizer) -> () in
      print("selected team 1")
      //            playAnimation()
      self.performSegueWithIdentifier("selected", sender: self)

    }
    
    teamTwoImageView.addTapGesture(tapNumber: 1) { (UITapGestureRecognizer) -> () in
      print("selected team 2")
      //            playAnimation()
      self.performSegueWithIdentifier("selected", sender: self)

    }
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
