//
//  Strategy.swift
//  TicTacToe
//
//  Created by Karol on 06/02/2017.
//  Copyright © 2017 Oleksandr Shtykhno. All rights reserved.
//

import Foundation

protocol PlayStrategy {
    func play(board: Board, player: Figure) -> Int
}

class MinimaxStrategy: PlayStrategy {
    private var choice : Int = -1
    private var player : Figure!
    
    private var minimaxCall : Int = 0
    private var scoreCall : Int = 0
    
    private func score(_ board: Board) -> Int {
        scoreCall += 1
        
        let winner = board.winner()
        if winner == nil {
            return 0
        } else if winner == player {
            return 10
        } else {
            return -10
        }
    }
    
    ///
    /// Minimax implementation for position specified by board
    /// and player X or 0 specified by player
    ///
    /// :returns: score(estimation) for this position
    ///
    private func minimax(_ board: Board, player: Figure) -> Int {
        minimaxCall += 1
        
        // no more movements - terminal state
        if !board.isMovePossible() {
            // returns score for terminal position
            return score(board)
        }
        
        var scores : Array<Int> = []
        var moves : Array<Int> = []
        
        let a = board.availableMoves()
        for move in a
        {
            let next = board.copy()
            next.set(move, figure: player)
            
            print(a)
            print(next.description)
            
            // save score for next move
            scores.append(minimax(next, player : (player == Figure.zero ? Figure.cross : Figure.zero)))
            // save index of the next move
            moves.append(move)
        }
        
        // for player choose maximum from moves
        if self.player == player {
            let index = max(scores)
            choice = moves[index]
            return scores[index]
        }
        else // for opposite side calculate minimum
        {
            let index = min(scores)
            choice = moves[index]
            return scores[index]
        }
    }
    
    private func min(_ array: Array<Int>) -> Int {
        var min = array[0]
        var result = 0
        for index in 1..<array.count {
            if (array[index] < min) {
                result = index;
                min = array[index]
            }
        }
        return result;
    }
    
    private func max(_ array: Array<Int>) -> Int {
        var max = array[0]
        var result = 0
        for index in 1..<array.count {
            if (array[index] > max) {
                result = index;
                max = array[index]
            }
        }
        return result;
    }

    func play(board: Board, player: Figure) -> Int {
        self.player = player
        _ = minimax(board, player: self.player)
        print("Stat minimax \(minimaxCall) score \(scoreCall)")
        
        return choice
    }
}

class HumanStrategy: PlayStrategy {
    func play(board: Board, player: Figure) -> Int {
        func input() -> String? {
            print("Input index of figure \(player.description):")
            return readLine(strippingNewline: true)
        }
        
        if let index = input() {
            return Int(index)!
        }
        
        return -1
    }
}
