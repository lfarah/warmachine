//
//  ViewController.swift
//  Nubee
//
//  Created by Lucas Farah on 1/20/16.
//  Copyright © 2016 Lucas Farah. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import Gifu
class ViewController: UIViewController {
  
  @IBOutlet weak var lblDescription: UILabel!
  @IBOutlet weak var lblWord: UILabel!
  @IBOutlet weak var lblWordExplanation: UILabel!
  @IBOutlet weak var imgvGif: UIImageView!
  
  @IBOutlet weak var imgvPlayer: UIImageView!
  
  @IBOutlet weak var imgvBaloon: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.playReader()
  }
  
  func playReader()
  {
    var count = 0
    var down = 0

    ez.runThisEvery(seconds: 5, handler: { (timer) -> Void in
      let play = self.readJSON()[count]
      print(count,down)
      let stringDescription = play["description"] as! String
//      print(stringDescription)
      
      let arrayDescription = stringDescription.componentsSeparatedByString(" ")
      let string2 = NSMutableAttributedString()
      let importantWord = play["importantWord"] as! String
      let profileImage = play["player"] as! String
//      print(profileImage)
      
      let eachWordExplanation = play["wordExplanation"] as! String
      self.lblWordExplanation.text = eachWordExplanation
      let giftFile = play["gifFile"] as! String
      
      let myGif = UIImage.gifWithName(giftFile)
      self.imgvGif.image = myGif
      
      let playerImage = UIImage(named: profileImage)

      self.imgvPlayer.image = playerImage
      
      self.lblWord.text = importantWord
      
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
      
      //HARDCODED
      if (play["team"] as! String == "NE" && fuckingAwesomeAlgorithm > 30) || (play["team"] as! String == "CAR" && fuckingAwesomeAlgorithm < 30)
      {
        self.imgvBaloon.image = UIImage(named:"GreenBaloon")
      }
      else
      {
        self.imgvBaloon.image = UIImage(named:"GreenBaloon")
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
      self.lblDescription.attributedText = string2
      
      if count < self.readJSON()[down].count - 1
      {
        count++
      }
      else if down < self.readJSON().count - 1
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

