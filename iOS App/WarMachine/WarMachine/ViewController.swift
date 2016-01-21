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
  
  @IBOutlet weak var bubble: UIImageView!
  @IBOutlet weak var imgvGIF: UIImageView!
  @IBOutlet weak var selectedWord: UILabel!
  @IBOutlet weak var strDescription: UILabel!
  @IBOutlet weak var patriotScore: UILabel!
  @IBOutlet weak var wordExplanation: UILabel!
  @IBOutlet weak var profile: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //    if selectedTeam == 0 {
    //      self.tabBarController?.tabBar.alpha = 0
    //      createPickTeamView()
    //      return
    //    }
    
    //    createScrollView()
    
    
    let path = NSBundle.mainBundle().pathForResource("riskyGame", ofType: "json")
    let jsonData = NSData(contentsOfFile: path!)
    
    do
    {
      let jsonArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
      //      print(jsonArray[0])
      
      var count = 0
      var down = 0
      ez.runThisEvery(seconds: 8, handler: { (timer) -> Void in
        
        let play = jsonArray[down][count]
        
        let stringDescription = play["description"] as! String
        let arrayDescription = stringDescription.componentsSeparatedByString(" ")
        let string2 = NSMutableAttributedString()
        let importantWord = play["importantWord"] as! String
        let profileImage = play["player"] as! String
        print(profileImage)
        
        let eachWordExplanation = play["wordExplanation"] as! String
        self.wordExplanation.text = eachWordExplanation
        let giftFile = play["gifFile"] as! String
        let myGif = UIImage.gifWithName(giftFile)
        self.imgvGIF.image = myGif
        
        let playerImage = UIImage(named: profileImage)
        print(playerImage)
        self.profile.image = playerImage
        
        self.selectedWord.text = importantWord
        
        let arrayImportantWord = importantWord.componentsSeparatedByString(" ")
        
        for word in arrayDescription
        {
          
          var shouldPrintRed = false
          for importantSelected in arrayImportantWord
          {
            if word == importantSelected || word == importantSelected + "," || word == "(" + importantSelected + ")"
            {
              shouldPrintRed = true
              break
              //
            }
            else
            {
              shouldPrintRed = false
            }
          }
          
          if shouldPrintRed == false
          {
            string2.appendAttributedString(NSAttributedString(string: word + " ", attributes: [
              NSFontAttributeName: UIFont.systemFontOfSize(15),
              NSForegroundColorAttributeName: UIColor.whiteColor()
              ]))
          }
          else
          {
            string2.appendAttributedString(NSAttributedString(string: word + " ", attributes: [
              NSFontAttributeName: UIFont.systemFontOfSize(16),
              NSForegroundColorAttributeName: UIColor.yellowColor()
              ]))
          }
          
        }
        
        let downs = play["down"] as! Double
        let distance = play["distance"] as! Double
        let fuckingAwesomeAlgorithm = downs * downs * distance
        
        if (play["team"] as! String == "NE" && fuckingAwesomeAlgorithm > 30) || (play["team"] as! String == "CAR" && fuckingAwesomeAlgorithm < 30)
        {
          self.bubble.image = UIImage(named:"Red Bubble")
        }
        else
        {
          self.bubble.image = UIImage(named:"Rectangle 2")
        }
        //    string2.appendAttributedString(NSAttributedString(string: "Hello ", attributes: [
        //      NSFontAttributeName: UIFont.systemFontOfSize(20),
        //      NSForegroundColorAttributeName: UIColor.redColor()
        //      ]))
        //    string2.appendAttributedString(NSAttributedString(string: "world ", attributes: [
        //      NSFontAttributeName: UIFont.systemFontOfSize(20),
        //      NSForegroundColorAttributeName: UIColor.redColor(),
        //      ]))
        //    string2.appendAttributedString(NSAttributedString(string: "of Swift ", attributes: [
        //      NSFontAttributeName: UIFont.systemFontOfSize(20),
        //      NSForegroundColorAttributeName: UIColor.redColor(),
        //      NSStrokeColorAttributeName: UIColor.orangeColor(),
        //      NSStrokeWidthAttributeName: -2
        //      ]))
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "swift")
        string2.appendAttributedString(NSAttributedString(attachment: attachment))
        self.strDescription.attributedText = string2
        
        if count < jsonArray[down].count - 1
        {
          count++
        }
        else if down < jsonArray.count - 1
        {
          down++
          count = 0
        }
        else
        {
          down = 0
          count = 0
        }
      })
    }
    catch let error{
      print(error)
    }
    
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
  
}

