//
//  ViewController.swift
//  Tarea 2
//
//  Created by Victor Elizalde on 1/24/17.
//  Copyright © 2017 Victor Elizalde. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var turnTF: UILabel!
    var activePlayer = 1
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var activeGame = true
    var iCont = 0
    var moveCounter = 0
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var isTied = false
    
    func winnerMessage(winner: String){
        
        if winner != "Tie" {
            
            let alert = UIAlertController(title: "Congratulations!", message: "\(winner) has won!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
        } else{
            
            let alert = UIAlertController(title: "Uh oh!", message: "There is a tie!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
        
        
    }


    @IBAction func pressBoard(_ sender: UIButton) {
        
        if gameState[sender.tag-1] == 0 && activeGame{
            
            gameState[sender.tag-1] = activePlayer
            
            if activePlayer == 1 {
                
                sender.setImage(UIImage(named: "Cross"), for:(UIControlState()))
                activePlayer = 2
                turnTF.text = "Circle"
                
            } else {
                
                sender.setImage(UIImage(named: "Circle"), for:(UIControlState()))
                activePlayer = 1
                turnTF.text = "Cross"
            }
            
            for combination in winningCombinations{
                
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]{
                    
                    //We have a winner
                    
                    activeGame = false
                    isTied = false
                    
                    
                    if gameState[combination[0]] == 1 {
                        
                        winnerMessage(winner: "Cross")
                        break
                        
                    } else {
                        
                        winnerMessage(winner: "Circle")
                        break
                        
                    }
                    
                }
                
            }
            
            moveCounter += 1
            
            if moveCounter >= 9 && activeGame {
                
                activeGame = false
                isTied = false
                winnerMessage(winner: "Tie")
                
            }
            
        }
        
    }

    @IBAction func playAgain(_ sender: UIButton) {
        
        activeGame = true
        gameState = [0,0,0,0,0,0,0,0,0]
        activePlayer = 1
        moveCounter = 0
        turnTF.text = "Cross"
        
        for i in 1..<10{
            
            if let button = view.viewWithTag(i) as? UIButton{
                button.setImage(nil, for: [])
            }
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        turnTF.text = "Cross"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

