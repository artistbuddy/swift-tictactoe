//
//  Player.swift
//  TicTacToe
//
//  Created by Oleksandr Shtykhno on 01/02/15.
//  Copyright (c) 2015 Oleksandr Shtykhno. All rights reserved.
//

import Foundation

protocol Player {
    var figure: Figure { get }
    func move()
}

class AbstractPlayer : Player {
    var board : Board
    var figure : Figure
    var strategy : PlayStrategy
    
    init(figure: Figure, board: Board, strategy: PlayStrategy) {
        self.figure = figure
        self.board = board
        self.strategy = strategy
    }
    
    func move() {
        let index = strategy.play(board: board, player: figure)
        board.set(index, figure: figure)
    }
}

class Human : AbstractPlayer {
    convenience init(figure: Figure, board: Board) {
        self.init(figure: figure, board: board, strategy: HumanStrategy())
    }
}


class Ai : AbstractPlayer {
    convenience init(figure: Figure, board: Board) {
        self.init(figure: figure, board: board, strategy: MinimaxStrategy())
    }
}
