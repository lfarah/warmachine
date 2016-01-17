//
//  ViewController.swift
//  WarMachine
//
//  Created by Lucas Farah on 1/16/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import Gifu

class ViewController: UIViewController {
  
  var scrollView: UIScrollView!
  var nowY: CGFloat!
  var headerHeight: CGFloat!
  var teamSelected: Bool!
  var selectedTeam: Int = 0
  
  @IBOutlet weak var imgvGIF: UIImageView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    if selectedTeam == 0 {
//      self.tabBarController?.tabBar.alpha = 0
//      createPickTeamView()
//      return
//    }
    
    //    createScrollView()
    
    let myGif = UIImage.gifWithName("interceptiongifs")
    self.imgvGIF.image = myGif
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func createScrollView() {
    self.tabBarController?.tabBar.alpha = 1
    let image = UIImage(named: "header.png")
    let headerView = UIImageView(image: image!)
    headerHeight = headerView.h * ez.screenWidth / headerView.w
    headerView.frame = CGRect(x: 0, y: 0, width: ez.screenWidth, height: headerHeight)
    self.view.addSubview(headerView)
    
    scrollView = UIScrollView(frame: CGRect(x: 0, y: headerView.h, width: ez.screenWidth, height: ez.screenHeight - headerView.h))
    scrollView.backgroundColor = UIColor.whiteColor()
    scrollView.pagingEnabled = true
    self.view.addSubview(scrollView)
    
    nowY = 0
    
    //        "homeScore":6,
    //        "down":-1,
    //        "description":"T.Masthay kicks 74 yards from GB 35 to MIN -9. C.Patterson for 109 yards, TOUCHDOWN.",
    //        "yardLine":65,
    //        "team":"Green Bay Packers",
    //        "awayScore":0,
    //        "time":"15:00",
    //        "playType":"Kickoff Return Touchdown"
    
    var descript = "T.Masthay kicks 74 yards from GB 35 to MIN -9. C.Patterson for 109 yards, TOUCHDOWN."
    
    createNewEntry("Awesome Playerr yeaa madafka yooogr regaerg", imageOneName: "testimg1.png", imageTwoName:  "testimg2.png", homeScore: "6", awayScore: "0", description: descript, yardLine: "25")
    createNewEntry("This Shit Sucks I hate this game ergrer", imageOneName: "testimg1.png", imageTwoName:  "testimg2.png", homeScore: "8", awayScore: "0", description: descript, yardLine: "45")
    createNewEntry("Go Pantherss gooo wuuuhuu wuuu ooo ii uu yy ", imageOneName: "testimg1.png", imageTwoName:  "testimg2.png", homeScore: "12", awayScore: "0", description: descript, yardLine: "65")
  }
  
  func createNewEntry(title: String, imageOneName: String, imageTwoName: String, homeScore: String, awayScore: String, description: String, yardLine: String) {
    let element = UIView(frame: CGRect(x: 0, y: nowY, width: ez.screenWidth, height: ez.screenHeight - headerHeight))
    //        element.backgroundColor = UIColor(patternImage: UIImage(named: "intro-1.png")!)
    //        element.backgroundColor = UIColor.whiteColor()
    element.addBorder(width: 1, color: UIColor.grayColor())
    
    //        let backgroundImage = UIImage(named: "intro-1.png")
    //        let backgroundImageView = UIImageView(image: backgroundImage!)
    //        backgroundImageView.frame = CGRect(x: 0, y: 0, width: ez.screenWidth, height: ez.screenHeight)
    //        backgroundImageView.alpha = 0.5
    //        element.addSubview(backgroundImageView)
    
    let myGif = UIImage.gifWithName("interceptiongifs")
    let gifView = UIImageView(x: 0, y: 150, w: ez.screenWidth, h: 400, image: myGif!)
    element.addSubview(gifView)
    element.sendSubviewToBack(gifView)
    
    let topImage = UIImage(named: "Rectangle 2")
    let topImageView = UIImageView(image: topImage!)
    topImageView.frame = CGRect(x: 0, y: 20, width: ez.screenWidth, height: 165)
    element.addSubview(topImageView)
    
    let bottomImage = UIImage(named: "bottom.png")
    let bottomImageView = UIImageView(image: bottomImage!)
    bottomImageView.frame = CGRect(x: 0, y: ez.screenHeight - 220, width: ez.screenWidth, height: 220)
    element.addSubview(bottomImageView)
    
    let playerImage = UIImage(named: imageOneName)
    let playerImageView = UIImageView(image: playerImage!)
    playerImageView.frame = CGRect(x: 10, y: 20, width: 100, height: 100)
    playerImageView.round()
    element.addSubview(playerImageView)
    
    //        let imageTwo = UIImage(named: imageTwoName)
    //        let imageViewTwo = UIImageView(image: imageTwo!)
    //        imageViewTwo.frame = CGRect(x: ez.screenWidth - 20 - 100, y: 200, width: 100, height: 100)
    //        element.addSubview(imageViewTwo)
    
    let label = UILabel(frame: CGRect(x: 0, y: 5, width: 0, height: 100))
    label.textColor = UIColor.blackColor()
    label.font = UIFont(name: label.font.fontName, size: 24)
    label.numberOfLines = 0
    label.text = title
    label.resizeToFitWidth()
    label.x = playerImageView.x + playerImageView.w
    label.w = ez.screenWidth - label.x - 20
    element.addSubview(label)
    
    //        let homeScoreLabel = UILabel(frame: CGRect(x: 0, y: 140, width: 0, height: 100))
    //        homeScoreLabel.textColor = UIColor.blackColor()
    //        homeScoreLabel.font = UIFont(name: homeScoreLabel.font.fontName, size: 25)
    //        homeScoreLabel.text = "Home Score: " + homeScore + " / Away Score: " + awayScore
    //        homeScoreLabel.resizeToFitWidth()
    //        homeScoreLabel.x = (ez.screenWidth - homeScoreLabel.w)/2
    //        element.addSubview(homeScoreLabel)
    //        
    //        let yardLineLabel = UILabel(frame: CGRect(x: 0, y: 170, width: 0, height: 100))
    //        yardLineLabel.textColor = UIColor.blackColor()
    //        yardLineLabel.font = UIFont(name: yardLineLabel.font.fontName, size: 25)
    //        yardLineLabel.text = "Yardline: " + yardLine
    //        yardLineLabel.resizeToFitWidth()
    //        yardLineLabel.x = (ez.screenWidth - yardLineLabel.w)/2
    //        element.addSubview(yardLineLabel)
    //        
    //        let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 350, width: ez.screenWidth - 40, height: 0))
    //        descriptionLabel.textColor = UIColor.blackColor()
    //        descriptionLabel.font = UIFont(name: descriptionLabel.font.fontName, size: 25)
    //        descriptionLabel.numberOfLines = 0
    //        descriptionLabel.text = description
    //        descriptionLabel.resizeToFitHeight()
    //        descriptionLabel.x = 20
    //        element.addSubview(descriptionLabel)
    
    
    
    nowY = nowY + element.h
    scrollView.addSubview(element)
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, CGFloat(nowY));
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
      self.selectedTeam = 1
      self.createScrollView()
      print("selected team 1")
      //            playAnimation()
    }
    
    teamTwoImageView.addTapGesture(tapNumber: 1) { (UITapGestureRecognizer) -> () in
      self.selectedTeam = 2
      self.createScrollView()
      print("selected team 2")
      //            playAnimation()
    }
  }
}

