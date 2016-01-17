//
//  ViewController.swift
//  WarMachine
//
//  Created by Lucas Farah on 1/16/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class ViewController: UIViewController {

    var scrollView: UIScrollView!
    var nowY: CGFloat!
    var headerHeight: CGFloat!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createPickTeam()
    
//    scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ez.screenWidth, height: ez.screenHeight))
//    scrollView.backgroundColor = UIColor.whiteColor()
//    self.view.addSubview(scrollView)
//    
//    let image = UIImage(named: "header.png")
//    let imageView = UIImageView(image: image!)
//    
//    headerHeight = imageView.h * ez.screenWidth / imageView.w
//    
//    imageView.frame = CGRect(x: 0, y: 0, width: ez.screenWidth, height: headerHeight)
//    scrollView.addSubview(imageView)
//    
//    nowY = imageView.h
//    
//    createNewEntry("Awesome Playerr", imageOneName: "testimg1.png", imageTwoName:  "testimg2.png")
//    createNewEntry("This Shit Sucks", imageOneName: "testimg1.png", imageTwoName:  "testimg2.png")
//    createNewEntry("Go Pantherss", imageOneName: "testimg1.png", imageTwoName:  "testimg2.png")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
    func createNewEntry(title: String, imageOneName: String, imageTwoName: String) {
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
        
        nowY = nowY + element.h
        scrollView.addSubview(element)
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, CGFloat(nowY));
    }
    
    func createPickTeam() {
        let image = UIImage(named: "testimg.png")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: ez.screenWidth, height: ez.screenHeight)
        self.view.addSubview(imageView)
//        
//        let image1 = UIImage(named: "testimg1.png")
//        let imageView2 = UIImageView(image: image!)
//        imageView.frame = CGRect(x: 10, y: 300, width: ez.screenWidth, height: ez.screenHeight)
//        self.view.addSubview(imageView)
//        
//        let image = UIImage(named: "testimg2.png")
//        let imageView = UIImageView(image: image!)
//        imageView.frame = CGRect(x: ez.screenWidth - 20 - 100, y: 300, width: 100, height: 100)
//        self.view.addSubview(imageView)
    }
}

