//
//  Word.swift
//  Hangman
//
//  Created by Richie Gurgul on 11/30/15.
//  Copyright (c) 2015 Richie Gurgul. All rights reserved.
//

import UIKit

class Word
{
    var word = ""
    
    init(string: String)
    {
        word = string
    }
    
    func charAtIndex(index: Int) -> Character
    {
        return Character(word.substringWithRange(Range(start: index, end: index)))
    }
    
}
