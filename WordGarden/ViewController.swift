//
//  ViewController.swift
//  WordGarden
//
//  Created by Alex Karacaoglu on 1/17/19.
//  Copyright © 2019 Alex Karacaoglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // PROPERTIES
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var wordsInGameText: UILabel!
    @IBOutlet weak var wordsGuessedText: UILabel!
    @IBOutlet weak var wordsMissedText: UILabel!
    @IBOutlet weak var wordsRemainingText: UILabel!
    
    var wordsToGuess = ["ALEX", "SWIFT", "COMPUTERS", "MAC", "GASSON", "PHONE", "FOOTBALL", "FLOWER"]
    var lettersGuessed = ""
    let maxIncorrectGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    var wordIndex = 0
    var wordsGuessed = 0
    var wordsMissed = 0
    var wordsRemaining = 0
    var win = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
        formatUserGuessLabel()
        wordsInGameText.text = "Words in Game: " + String(wordsToGuess.count)
        wordsRemainingText.text = "Words Remaining: " + String(wordsToGuess.count)
        wordsRemaining = wordsToGuess.count
    }
    
    // FUNCTIONS
    func updateUiAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    func guess() {
        formatUserGuessLabel()
        
        guessCount += 1
        
        if !wordsToGuess[wordIndex].contains(guessedLetterField.text!) {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        
        let guess = (guessCount == 1 ? "Guess" : "Guesses")
        let revealedWord = userGuessLabel.text!
        
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You Ran Out Of Guesses. Try Again!"
            win = false
        }
        else if !revealedWord.contains("_") {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You Won! It Took You \(guessCount) \(guess)"
            win = true
        }
        else {
            guessCountLabel.text = "You've Made \(guessCount) \(guess)"
        }
    }
    
    func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        
        for letter in wordsToGuess[wordIndex] {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + String(" " + String(letter))
            }
            else {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    // ACTIONS
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
                if let letterGuessed = guessedLetterField.text?.last {
                    guessedLetterField.text = String(letterGuessed)
                    guessLetterButton.isEnabled = true
                }
                else {
                    guessLetterButton.isEnabled = false
                }
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guess()
        print("BUTTON PRESSED")
        updateUiAfterGuess()
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guess()
        print("DONE KEY PRESSED")
        updateUiAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxIncorrectGuesses
        lettersGuessed = ""
        guessCountLabel.text = "You've Made 0 Guesses"
        guessCount = 0
        wordIndex += 1
        if wordIndex == wordsToGuess.count {
            wordIndex = 0
        }
        wordsRemaining = wordsToGuess.count - wordIndex
        wordsRemainingText.text = "Words Remaining: \(wordsRemaining)"
        if win {
            wordsGuessed += 1
            wordsGuessedText.text = "Words Guessed: \(wordsGuessed)"
        }
        else {
            wordsMissed += 1
            wordsMissedText.text = "Words Missed: \(wordsMissed)"
        }
        formatUserGuessLabel()
    }

}
