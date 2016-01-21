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
    let image = UIImage(named: "pickteambackground.png")
    let imageView = UIImageView(image: image!)
    imageView.frame = CGRect(x: 0, y: 0, width: ez.screenWidth, height: ez.screenHeight)
    self.view.addSubview(imageView)
    
    let teamOneLogo = UIImage(named: "panthers.png")
    let teamOneLogoView = UIImageView(image: teamOneLogo!)
    teamOneLogoView.frame = CGRect (x: 800, y: 0, w: 180, h: 180)
    teamOneLogoView.y = ez.screenHeight/2 - teamOneLogoView.h
    self.view.addSubview(teamOneLogoView)
    
    let teamTwoLogo = UIImage(named: "patriots.png")
    let teamTwoLogoView = UIImageView(image: teamTwoLogo!)
    teamTwoLogoView.frame = CGRect (x: -800, y: 450, w: 180, h: 180)
    teamTwoLogoView.y = ez.screenHeight/2 + 100
    self.view.addSubview(teamTwoLogoView)
    
    let lineView = UIView(x: 0, y: 0, w: 300, h: 5)
    lineView.addBorder(width: 3, color: UIColor.grayColor())
    lineView.x = ez.screenWidth/2 - 150
    lineView.y = ez.screenHeight/2 - 5
    lineView.alpha = 0
    self.view.addSubview(lineView)
    
    let vsImage = UIImage(named: "vs.png")
    let vsImageView = UIImageView(image: vsImage!)
    vsImageView.frame = CGRect (x: 0, y: 0, w: 60, h: 60)
    vsImageView.x = ez.screenWidth/2  - 30
    vsImageView.y = ez.screenHeight/2 - vsImageView.y/2 + 25
    vsImageView.alpha = 1.0
    self.view.addSubview(vsImageView)
    
    lineView.y = vsImageView.y + 25
    print("asd")
    
    


    ez.runThisAfterDelay(seconds: 0.2) { () -> () in
        
        UIView.animateWithDuration(2) { () -> Void in
            print("11")
            vsImageView.transform = CGAffineTransformMakeRotation((180.0 * CGFloat(M_PI)) / 180.0)
            vsImageView.transform = CGAffineTransformMakeScale(0.3, 0.3)
            UIView.animateWithDuration(2) { () -> Void in
                vsImageView.transform = CGAffineTransformMakeRotation((360.0 * CGFloat(M_PI)) / 180.0)
            }
        }
        
        UIView.animateWithDuration(2, animations: { () -> Void in
            teamOneLogoView.x = ez.screenWidth/2 - teamOneLogoView.w/2
            print(teamOneLogoView.x)
            teamTwoLogoView.x = ez.screenWidth/2 - teamOneLogoView.w/2
            //        vsImageView.alpha = 1.0
            lineView.alpha = 1.0
            //        vsImageView.w = 60
            print("555")
            
            }) { (Bool) -> Void in
                print(77777)
        }
    }
    
    
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
