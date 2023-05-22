//
//  ViewController.swift
//  2048_LazarStefania_Grupa333
//
//  Created by Student on 24.04.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var congratulationsLabel: UILabel!


        
    let gameLogic = GameLogic(size: boardSize)
    
    private let reuseIdentifier = "TileCollectionViewCell"


    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeUp.direction = .up
        collectionView.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeDown.direction = .down
        collectionView.addGestureRecognizer(swipeDown)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        collectionView.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        collectionView.addGestureRecognizer(swipeRight)

        collectionView.backgroundColor = UIColor(red: 0.00, green: 0.27, blue: 0.13, alpha: 1.00)
        collectionView.register(TileCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        congratulationsLabel.text = "Congratulations! You won!"
        updateScore()
        
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            gameLogic.move(.up)
        case .down:
            gameLogic.move(.down)
        case .left:
            gameLogic.move(.left)
        case .right:
            gameLogic.move(.right)
        default:
            break
        }
        gameLogic.generateNewTile()
        collectionView.reloadData()
        updateScore()
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardSize * boardSize
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TileCell", for: indexPath) as! TileCollectionViewCell
        let row = indexPath.item / boardSize
        let column = indexPath.item % boardSize
        
        let value = gameLogic.board[row][column]
        cell.valueLabel.text = value == 0 ? "" : "\(value)"
        
        cell.backgroundColor = getColorForValue(value)

        return cell
    }
    
    func updateGameBoard(moveDirection: GameLogic.MoveDirection) {
        gameLogic.move(moveDirection)
        collectionView.reloadData()
    }
    
    var currentScore = 0

    func updateScore() {
        currentScore = 0
        var isWin = false

        for i in 0..<gameLogic.board.count {
            for j in 0..<gameLogic.board[i].count {
                currentScore += gameLogic.board[i][j]
                if gameLogic.board[i][j] == winningValue {
                    isWin = true
                }
            }
        }

        // Update the score label
        scoreLabel.text = "Score: \(currentScore)"
        
        // Show the "Congratulations" message if the winning value is reached
        if isWin {
            congratulationsLabel.text = "You won!"
        } else {
            congratulationsLabel.text = ""
        }
    }
    
    func getColorForValue(_ value: Int) -> UIColor {
        switch value {
        case 2:
            return UIColor(red: 255/255, green: 250/255, blue: 215/255, alpha: 1)
        case 4:
            return UIColor(red: 252/255, green: 221/255, blue: 176/255, alpha: 1)
        case 8:
            return UIColor(red: 255/255, green: 159/255, blue: 159/255, alpha: 1)
        case 16:
            return UIColor(red: 215/255, green: 248/255, blue: 247/255, alpha: 1)
        case 32:
            return UIColor(red: 190/255, green: 228/255, blue: 210/255, alpha: 1)
        case 64:
            return UIColor(red: 250/255, green: 178/255, blue: 172/255, alpha: 1)
        case 128, 256, 512, 1024, 2048:
            return UIColor(red: 233/255, green: 119/255, blue: 119/255, alpha: 1)
        default:
            return UIColor(red: 255/255, green: 240/255, blue: 240/255, alpha: 1)
        }
    }




    
    


}

