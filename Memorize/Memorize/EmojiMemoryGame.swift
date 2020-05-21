//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Chris Sanders on 5/20/20.
//  Copyright © 2020 Chris Sanders. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame {
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        var emojis = ["👻", "🎃", "🕷", "🦇", "🧹", "🤵🏾", "🤬", "🐘", "⛺️", "🤢", "👍🏾", "🧞‍♀️", "👨🏾‍💻", "😻", "🤗"]
        emojis = emojis.shuffled()
        emojis = Array(emojis.prefix(5))
        let randomNumber = Int.random(in: 2...5)
        return MemoryGame<String>(numberOfPairsOfCards: randomNumber) { pairIndex in
            return emojis[pairIndex]
            
        }
    }
        
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }

    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}

struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
