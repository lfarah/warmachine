//
//  UITabBarController.swift
//  WarMachine
//
//  Created by Demir Yilmaz on 1/16/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class SecondViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var nowY: CGFloat!
    var headerHeight: CGFloat!
    var teamSelected: Bool!
    var selectedTeam: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("aaaa")
        createScrollView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createScrollView() {
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
        
        let descript = "T.Masthay kicks 74 yards from GB 35 to MIN -9. C.Patterson for 109 yards, TOUCHDOWN."
        
        createNewEntry("Awesome Playerr", imageOneName: "testimg1.png", imageTwoName:  "testimg2.png", homeScore: "6", awayScore: "0", description: descript, yardLine: "25")
        createNewEntry("This Shit Sucks", imageOneName: "testimg1.png", imageTwoName:  "testimg2.png", homeScore: "8", awayScore: "0", description: descript, yardLine: "45")
        createNewEntry("Go Pantherss", imageOneName: "testimg1.png", imageTwoName:  "testimg2.png", homeScore: "12", awayScore: "0", description: descript, yardLine: "65")
    }
    
    func createNewEntry(title: String, imageOneName: String, imageTwoName: String, homeScore: String, awayScore: String, description: String, yardLine: String) {
        let element = UIView(frame: CGRect(x: 0, y: nowY, width: ez.screenWidth, height: ez.screenHeight - headerHeight))
        //        element.backgroundColor = UIColor(patternImage: UIImage(named: imageName)!)
        element.backgroundColor = UIColor.whiteColor()
        element.addBorder(width: 1, color: UIColor.grayColor())
        
        let image = UIImage(named: imageOneName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 20, y: 200, width: 100, height: 100)
        element.addSubview(imageView)
        
        let imageTwo = UIImage(named: imageTwoName)
        let imageViewTwo = UIImageView(image: imageTwo!)
        imageViewTwo.frame = CGRect(x: ez.screenWidth - 20 - 100, y: 200, width: 100, height: 100)
        element.addSubview(imageViewTwo)
        
        let label = UILabel(frame: CGRect(x: 0, y: 30, width: 0, height: 100))
        label.textColor = UIColor.blackColor()
        label.font = UIFont(name: label.font.fontName, size: 30)
        label.text = title
        label.resizeToFitWidth()
        label.x = (ez.screenWidth - label.w)/2
        element.addSubview(label)
        
        let homeScoreLabel = UILabel(frame: CGRect(x: 0, y: 70, width: 0, height: 100))
        homeScoreLabel.textColor = UIColor.blackColor()
        homeScoreLabel.font = UIFont(name: homeScoreLabel.font.fontName, size: 25)
        homeScoreLabel.text = "Home Score: " + homeScore + " / Away Score: " + awayScore
        homeScoreLabel.resizeToFitWidth()
        homeScoreLabel.x = (ez.screenWidth - homeScoreLabel.w)/2
        element.addSubview(homeScoreLabel)
        
        let yardLineLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 0, height: 100))
        yardLineLabel.textColor = UIColor.blackColor()
        yardLineLabel.font = UIFont(name: yardLineLabel.font.fontName, size: 25)
        yardLineLabel.text = "Yardline: " + yardLine
        yardLineLabel.resizeToFitWidth()
        yardLineLabel.x = (ez.screenWidth - yardLineLabel.w)/2
        element.addSubview(yardLineLabel)
        
        let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 350, width: ez.screenWidth - 40, height: 0))
        descriptionLabel.textColor = UIColor.blackColor()
        descriptionLabel.font = UIFont(name: descriptionLabel.font.fontName, size: 25)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = description
        descriptionLabel.resizeToFitHeight()
        descriptionLabel.x = 20
        element.addSubview(descriptionLabel)
        
        nowY = nowY + element.h
        scrollView.addSubview(element)
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, CGFloat(nowY));
    }
}