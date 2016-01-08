//
//  ViewController.swift
//  Hangman
//
//  Created by Richie Gurgul on 11/19/15.
//  Copyright (c) 2015 Richie Gurgul. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
    //OUTLETS
    @IBOutlet weak var wordField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        //Once the user starts editing the text field, the button becomes enabled
        goButton.userInteractionEnabled = true
        goButton.titleLabel?.textColor = UIColor.blueColor()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        //Once the user hits return, the next view will appear
        performSegueWithIdentifier("toPlayScreen", sender: textField)
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        //Once the user hits the button, the next view will appear, and set its word to the user's input
        let nextVC = segue.destinationViewController as! NextViewController
        nextVC.word = self.wordField.text!.lowercaseString
    }
    
}

