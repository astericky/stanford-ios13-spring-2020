//
//  Array+Only.swift
//  Memorize
//
//  Created by Chris Sanders on 6/2/20.
//  Copyright © 2020 Chris Sanders. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
