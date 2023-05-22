import Foundation

let boardSize = 4
let initialTileCount = 2
let winningValue = 2048

class GameLogic {
    var board: [[Int]]
    
    init(size: Int) {
        board = Array(repeating: Array(repeating: 0, count: size), count: size)
        generateNewTile()
        generateNewTile()
    }
    
    func generateNewTile() {
        let emptyPositions = getEmptyPositions()
        
        if let randomEmptyPosition = emptyPositions.randomElement() {
            let randomNumber = (Int.random(in: 0..<10) < 9) ? 2 : 4
            board[randomEmptyPosition.row][randomEmptyPosition.column] = randomNumber
        }
    }
    
    func getEmptyPositions() -> [(row: Int, column: Int)] {
        var emptyPositions: [(row: Int, column: Int)] = []
        
        for row in 0..<boardSize {
            for column in 0..<boardSize {
                if board[row][column] == 0 {
                    emptyPositions.append((row: row, column: column))
                }
            }
        }
        
        return emptyPositions
    }
    
    enum MoveDirection {
        case up, down, left, right
    }
    
    func move(_ direction: MoveDirection) {
        
        switch direction {
        case .up:
            for column in 0..<boardSize {
                var mergedTiles = Array(repeating: false, count: boardSize)
                
                for row in 1..<boardSize {
                    var currentRow = row
                    
                    while currentRow > 0 && board[currentRow - 1][column] == 0 {
                        board[currentRow - 1][column] = board[currentRow][column]
                        board[currentRow][column] = 0
                        currentRow -= 1
                    }
                    
                    if currentRow > 0 && board[currentRow - 1][column] == board[currentRow][column] && !mergedTiles[currentRow - 1] {
                        board[currentRow - 1][column] *= 2
                        board[currentRow][column] = 0
                        mergedTiles[currentRow - 1] = true
                    }
                }
            }
        case .down:
            for column in 0..<boardSize {
                var mergedTiles = Array(repeating: false, count: boardSize)
                
                for row in (0..<boardSize - 1).reversed() {
                    var currentRow = row
                    
                    while currentRow < boardSize - 1 && board[currentRow + 1][column] == 0 {
                        board[currentRow + 1][column] = board[currentRow][column]
                        board[currentRow][column] = 0
                        currentRow += 1
                    }
                    
                    if currentRow < boardSize - 1 && board[currentRow + 1][column] == board[currentRow][column] && !mergedTiles[currentRow + 1] {
                        board[currentRow + 1][column] *= 2
                        board[currentRow][column] = 0
                        mergedTiles[currentRow + 1] = true
                    }
                }
            }
        case .left:
            for row in 0..<boardSize {
                var mergedTiles = Array(repeating: false, count: boardSize)
                
                for column in 1..<boardSize {
                    var currentColumn = column
                    
                    while currentColumn > 0 && board[row][currentColumn - 1] == 0 {
                        board[row][currentColumn - 1] = board[row][currentColumn]
                        board[row][currentColumn] = 0
                        currentColumn -= 1
                    }
                    
                    if currentColumn > 0 && board[row][currentColumn - 1] == board[row][currentColumn] && !mergedTiles[currentColumn - 1] {
                        board[row][currentColumn - 1] *= 2
                        board[row][currentColumn] = 0
                        mergedTiles[currentColumn - 1] = true
                    }
                }
            }
        case .right:
            for row in 0..<boardSize {
                var mergedTiles = Array(repeating: false, count: boardSize)
                
                for column in (0..<boardSize - 1).reversed() {
                    var currentColumn = column
                    
                    while currentColumn < boardSize - 1 && board[row][currentColumn + 1] == 0 {
                        board[row][currentColumn + 1] = board[row][currentColumn]
                        board[row][currentColumn] = 0
                        currentColumn += 1
                    }
                    
                    if currentColumn < boardSize - 1 && board[row][currentColumn + 1] == board[row][currentColumn] && !mergedTiles[currentColumn + 1] {
                        board[row][currentColumn + 1] *= 2
                        board[row][currentColumn] = 0
                        mergedTiles[currentColumn + 1] = true
                    }
                }
            }
        }
    }
            
            
    func hasValidMoves() -> Bool {
        for row in 0..<boardSize {
            for column in 0..<boardSize {
                if board[row][column] == 0 {
                    return true
                }
                
                if row < boardSize - 1 && board[row][column] == board[row + 1][column] {
                    return true
                }
                
                if column < boardSize - 1 && board[row][column] == board[row][column + 1] {
                    return true
                }
            }
        }
        
        return false
    }
    
    func isGameOver() -> Bool {
        for row in 0..<boardSize {
            for column in 0..<boardSize {
                if board[row][column] == winningValue {
                    return true
                }
            }
        }
        
        return !hasValidMoves()
    }
}
    
