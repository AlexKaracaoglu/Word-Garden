//
//  ViewController.swift
//  WordGarden
//
//  Created by Alex Karacaoglu on 1/17/19.
//  Copyright © 2019 Alex Karacaoglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
//    @IBOutlet weak var wordsRemainingText: UILabel!
//    @IBOutlet weak var wordsInGame: UILabel!
//    @IBOutlet weak var wordsMissedText: UILabel!
//    @IBOutlet weak var wordsGuessedText: UILabel!
    
    var wordsToGuess = ["ALEX", "SWIFT", "COMPUTERS", "MAC", "GASSON", "PHONE", "FOOTBALL", "FLOWER"]
    var lettersGuessed = ""
    let maxIncorrectGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    var wordIndex = 0
    var wordsGuessed = 0
    var wordsMissed = 0
    var wordsRemaining = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
        formatUserGuessLabel()
//        wordsInGame.text = "Words in Game: " + String(wordsToGuess.count)
//        wordsRemainingText.text = "Words Remaining: " + String(wordsToGuess.count)
//        wordsRemaining = wordsToGuess.count
    }
    
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
//            wordsMissed += 1
//            wordsMissedText.text = "Words Missed: \(wordsMissed)"
        }
        else if !revealedWord.contains("_") {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You Won! It Took You \(guessCount) \(guess)"
//            wordsGuessed += 1
//            wordsGuessedText.text = "Words Guessed: \(wordsGuessed)"
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
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = String(letterGuessed)
            guessLetterButton.isEnabled = true
        }
        else {
            guessLetterButton.isEnabled = false
        }
        
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guess()
        updateUiAfterGuess()
    }
    
    @IBAction func guessLetterButton(_ sender: UIButton) {
        guess()
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
//        wordsRemaining = wordsToGuess.count - wordIndex
//        wordsRemainingText.text = "Words Remaining: \(wordsRemaining)"
        formatUserGuessLabel()
    }

}
