//
//  ViewController2.swift
//  Hangman
//
//  Created by Richie Gurgul on 11/20/15.
//  Copyright (c) 2015 Richie Gurgul. All rights reserved.
//

import UIKit

class NextViewController: UIViewController, UITextFieldDelegate
{
    //OUTLETS
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var usedDisplay: UITextView!
    @IBOutlet weak var textDisplay: UITextView!
    @IBOutlet weak var guessField: UITextField!
    @IBOutlet weak var menuButton: UIButton!
    
    //VARIABLES
    var correctLetters = [Character]()
    var guessedLetters = [Character]()
    var usedLetters = [Character]()
    var word = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Makes the word into an array of letters
        correctLetters = Array(word.characters)
        
        //Makes an array to hold the correctly guessed letters
        guessedLetters = toBlankArray()
        
        displayText()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        let guess = guessField.text! as String
        
        //If the user guesses a letter
        if guess.characters.count == 1
        {
            //Then check the letter
            checkLetter(Character(guess))
        }
        //If the user guesses a word
        else if guess.characters.count > 1
        {
            //Then check the word
            checkWord(guess)
        }
        
        //Reset the user's guess in the text field
        guessField.text = ""
        displayText()
        return true
    }
    
    func displayText()
    {
        //Create a variable to hold the string to be displayed with the correctly guessed letters
        var text = ""
        var letters = 0
        for letter in guessedLetters
        {
            text += "\(letter) "
            letters++
            
            //If there are too many letters on a certain line, then it will be carried over to the next line
            if letters > 13 && letter == " "
            {
                text += "\n"
                letters = 0
            }
            else if letter == " "
            {
                text += " "
            }
        }
        textDisplay.text = text
        
        //Create a variable to hold the string to be displayed with the already used letters
        var used = "Used Letters: "
        var index = 1
        for letter in usedLetters
        {
            used += "\(letter)"
            if index < usedLetters.count
            {
                used += ", "
                index++
            }
        }
        usedDisplay.text = used
    }
    
    func checkLetter(guess: Character)
    {
        var index = 0
        
        //If the word contains the user's guess
        if (word as NSString).containsString(String(guess))
        {
            //Then it will check each letter and add the correct guess into the correctly guessed letters array
            for letter in correctLetters
            {
                if letter == guess
                {
                    guessedLetters[index] = guess
                }
                index++
            }
        }
        //Otherwise
        else
        {
            //Check if the letter has already been used
            var alreadyUsed = false
            for letter in usedLetters
            {
                if letter == guess
                {
                    alreadyUsed = true
                    break
                }
            }
            
            //If the letter has not been used yet
            if !alreadyUsed
            {
                //Then add it to the used letters array, update the image, and get rid of the keyboard
                usedLetters.append(guess)
                refreshImage(usedLetters.count)
                guessField.resignFirstResponder()
                
                //If the player uses up all of their 6 attempts
                if usedLetters.count >= 6
                {
                    //Then the player loses
                    endAlert("lost!")
                }
            }
        }
        
        //If the player guesses all of the correct letters
        if guessedLetters == correctLetters
        {
            //Then the player wins
            endAlert("won!")
        }
    }
    
    func checkWord(guess: String)
    {
        //If the player correctly guesses the word
        if guess == word
        {
            //Then the player wins
            endAlert("won!")
        }
        //Otherwise
        else
        {
            //Then the player loses
            endAlert("lost!")
        }
    }
    
    func refreshImage(number: Int)
    {
        //Updates the image to represent how many attempts the player has made
        hangmanImage.image = UIImage(named: "hangman_\(number)")
        
        /*switch number
        {
        case 1: //Head
            hangmanImage.image = UIImage(named: "hangman_1")
        case 2: //Head, Body
            hangmanImage.image = UIImage(named: "hangman_2")
        case 3: //Head, Body, Left Arm
            hangmanImage.image = UIImage(named: "hangman_3")
        case 4: //Head, Body, Left Arm, Right Arm
            hangmanImage.image = UIImage(named: "hangman_4")
        case 5: //Head, Body, Left Arm, Right Arm, Left Leg
            hangmanImage.image = UIImage(named: "hangman_5")
        case 6: //Head, Body, Left Arm, Right Arm, Left Leg, Right Leg
            hangmanImage.image = UIImage(named: "hangman_6")
        case 7: //Dead
            hangmanImage.image = UIImage(named: "hangman_7")
        default: //Gallows Empty
            hangmanImage.image = UIImage(named: "hangman_0")
        }*/
    }
    
    func toBlankArray() -> [Character]
    {
        var blankArray = [Character]()
        
        //Iterate through the letters
        for letter in word.characters
        {
            switch letter
            {
            //Symbols are given
            case "\"":
                blankArray.append("\"")
            case "'":
                blankArray.append("'")
            case "/":
                blankArray.append("/")
            case "-":
                blankArray.append("-")
            case "+":
                blankArray.append("+")
            case "=":
                blankArray.append("=")
            case "~":
                blankArray.append("~")
            case "(":
                blankArray.append("(")
            case ")":
                blankArray.append(")")
            case "#":
                blankArray.append("#")
            case "&":
                blankArray.append("&")
            case "@":
                blankArray.append("@")
            case "$":
                blankArray.append("$")
            case "%":
                blankArray.append("%")
            case "*":
                blankArray.append("*")
            case ":":
                blankArray.append(":")
            case ";":
                blankArray.append(";")
            case ",":
                blankArray.append(",")
            case ".":
                blankArray.append(".")
            case "?":
                blankArray.append("?")
            case "!":
                blankArray.append("!")
            case "_":
                blankArray.append(" ")
            case " ":
                blankArray.append(" ")
            //Anything else is replaced with an underscore (blank)
            default:
                blankArray.append("_")
            }
        }
        
        return blankArray
    }
    
    func endAlert(custom: String)
    {
        //If the player lost
        if custom == "lost!"
        {
            //Then show the final image, and disable the text field
            refreshImage(7)
            guessField.userInteractionEnabled = false
        }
        
        //Create the alert to end the game
        let alert = UIAlertController(title: "You \(custom)", message: "The phrase was: \n\"\(word)\"", preferredStyle: UIAlertControllerStyle.Alert)
        let reset = UIAlertAction(title: "Play again.", style: UIAlertActionStyle.Default, handler: {sender in
            self.menuButton.userInteractionEnabled = true
            self.menuButton.titleLabel?.textColor = UIColor.blueColor()
            self.guessField.resignFirstResponder()
        })
        
        //Present the alert
        alert.addAction(reset)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //FIN
    
}