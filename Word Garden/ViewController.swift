//
//  ViewController.swift
//  Word Garden
//
//  Created by Matt Giovanniello on 9/17/17.
//  Copyright © 2017 Matt Giovanniello. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userGuessLabel: UILabel!
    
    @IBOutlet weak var guessedLetterField: UITextField!
    
    @IBOutlet weak var guessLetterButton: UIButton!
    
    @IBOutlet weak var guessCountLabel: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var flowerImageView: UIImageView!
    
    var wordToGuess = "CODE"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
      formatUserGuessLabel()
    }
    
    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    func formatUserGuessLabel() {
        
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " " + "\(letter)"
            } else {
                revealedWord += " _"
            }
        }
        
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    
    func guessALetter() {
        formatUserGuessLabel()
        guessCount += 1
        
        // decrements the wrongGuessesRemaining and shows the next flower image with one less pedal
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed) {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
            let revealedWord = userGuessLabel.text!
            
            // stop game if wrongGuessesRemaining = 0
            if wrongGuessesRemaining == 0 {
                playAgainButton.isHidden = false
                guessedLetterField.isEnabled = false
                guessLetterButton.isEnabled = false
                guessCountLabel.text = "So sorry, you're all out of guesses. Try again?"
            } else if !revealedWord.contains("_") {
                // you've won!
                playAgainButton.isHidden = false
                guessedLetterField.isEnabled = false
                guessLetterButton.isEnabled = false
                guessCountLabel.text = "You've got it! It took you \(guessCount) guesses to guess the word!"
            } else {
                // update our guess count
                let guess = ( guessCount == 1 ? "guess" : "guesses" )
//                var guess = "guesses"
//                if guessCount == 1 {
//                    guess = "guess"
//                }
                
                guessCountLabel.text = "You've made \(guessCount) \(guess)"
            }
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
            
        } else {
            
           //disable the button
            guessLetterButton.isEnabled = false
            
        }
    }
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've made 0 guesses."
        guessCount = 0
    }
    
}

