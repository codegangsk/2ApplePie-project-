//
//  ViewController.swift
//  Apple Pie
//
//  Created by Sophie Kim on 2020/08/08.
//  Copyright © 2020 Sophie Kim. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    var listOfWords = ["apple", "dog", "cat", "game", "tree", "book", "pie", "pizza", "pasta", "bread"]
       let incorrectMovesAllowed = 7
       
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    
}


extension ViewController {
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let chosenLetter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: chosenLetter)
        updateGameState()
    }
    func newRound() {
        if !listOfWords.isEmpty {
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
        updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
}
