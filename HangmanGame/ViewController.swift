//
//  ViewController.swift
//  HangmanGame
//
//  Created by Артем Михайлов on 15.10.2022.
//

import UIKit

class ViewController: UIViewController {
    var scoreLabel: UILabel!
    var promptLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var wrongAnswer = 0
    var word = ""
    var wordLetterArray = [String]()
    var maskedWordString = ""
    var maskedWordArray = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        promptLabel = UILabel()
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        promptLabel.textAlignment = .center
        promptLabel.textColor = .black
        promptLabel.font = UIFont.systemFont(ofSize: 36)
        view.addSubview(promptLabel)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            promptLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            promptLabel.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 312),
            buttonsView.heightAnchor.constraint(equalToConstant: 174),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -100)
        ])
        
        let width = 36
        let height = 36
        
        for row in 0..<4 {
            for column in 0..<7 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 21)
                letterButton.setTitle("W", for: .normal)
                letterButton.layer.cornerRadius = 10
                letterButton.layer.borderColor = UIColor.gray.cgColor
                letterButton.layer.borderWidth = 1
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: (column * 10) + (column * width), y: (row * 10) + (row * height), width: width, height: height)
                letterButton.frame = frame
                
                if row == 3 {
                  letterButton.frame = CGRect(x: 46 + (column * 10) + (column * width),  y: (row * 10) + (row * height), width: width, height: height)
                }
                
                if (row == 3 && column == 5) {
                  continue
                }
                
                if (row == 3 && column == 6) {
                  continue
                }
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
        
        let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

        for i in 0..<letterButtons.count {
          letterButtons[i].setTitle(alphabet[i], for: .normal)
        }
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        var usedLetters = [String]()
        
        guard let letterChosen = sender.titleLabel?.text else { return }
        
        sender.isHidden = true
        
        usedLetters.append(letterChosen)
        
        if wordLetterArray.contains(letterChosen) {

            for (index, letter) in wordLetterArray.enumerated() {
            
                if letterChosen == letter {
                    maskedWordArray[index] = letter
                    score += 1
                }
            }
          
            maskedWordString = maskedWordArray.joined()
            
        } else {
            score -= 1
            wrongAnswer += 1
        }
        
        promptLabel.text = maskedWordString
    }
    
    func loadLevel() {
        word = "HANGMAN"

        for letter in word {
          wordLetterArray.append(String(letter))
        }

        print(wordLetterArray)
        print(word)

        for _ in 0..<wordLetterArray.count {
          maskedWordString += "*"
          maskedWordArray.append("*")
        }

        promptLabel.text = maskedWordString
    }
}

