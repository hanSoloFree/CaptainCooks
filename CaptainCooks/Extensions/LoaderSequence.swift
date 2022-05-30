//
//  LoaderSequence.swift
//  JackotCity
//
//  Created by Vsevolod Shelaiev on 14.12.2021.
//

import UIKit

struct LoaderSequence: Sequence, IteratorProtocol {
    var current = 0.1

    mutating func next() -> CGFloat? {
        defer {
            current += 0.1
        }

        return CGFloat(current)
    }
}
