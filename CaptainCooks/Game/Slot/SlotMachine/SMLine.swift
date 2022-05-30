//
//  SMLine.swift
//  slot
//
//  Created by 1 on 23.11.2021.
//

import Foundation

struct SMLine {
    let points: [SMPoint]
    
    init(_ line: [Int]) {
        self.points = line.enumerated().map { return SMPoint(row: $0.element, col: $0.offset) }
    }
    
    static let lines35: [SMLine] = {
        let all3to5lines = [
            [0,0,0,0,0],
            [1,1,1,1,1],
            [2,2,2,2,2],
            [0,1,2,1,0],
            [2,1,0,1,2],
            [0,0,1,2,2],
            [2,2,1,0,0],
            [1,0,1,2,1],
            [1,2,1,0,1],
            [0,1,1,1,2],
            [2,1,1,1,0],
            [1,1,2,2,0],
            [2,2,1,1,0],
            [0,1,1,1,1],
            [1,0,1,0,1]
        ]
        return all3to5lines.map { SMLine($0) }
    }()
}

struct SMPoint {
    let row: Int
    let col: Int
}
