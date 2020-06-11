//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Chris Sanders on 5/28/20.
//  Copyright © 2020 Chris Sanders. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
