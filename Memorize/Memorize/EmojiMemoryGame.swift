//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Chris Sanders on 5/20/20.
//  Copyright © 2020 Chris Sanders. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    static var theme: Theme?

    static var themes = [
        Theme(name: "Halloween", emojis: ["🕷", "👻", "🦇", "🎃", "🧹", "🧛🏾‍♂️"], numberOfPairsOfCards: nil, color: Color.orange),
        Theme(name: "Government", emojis: ["👮🏾‍♀️", "🗽", "⛪️", "🚓", "🚨", "🛑"], numberOfPairsOfCards: 4, color: Color.blue),
        Theme(name: "Nature", emojis: ["🌲", "🐇", "🐓", "☘️", "🍄", "🌾"], numberOfPairsOfCards: 5, color: Color.green),
        Theme(name: "Heart", emojis: ["👨‍❤️‍💋‍👨", "💝", "❤️", "💗", "🏩", "💌"], numberOfPairsOfCards: nil, color: Color.red),
        Theme(name: "Smiley", emojis: ["😁", "😌", "😎", "🤩", "🥳", "😂"], numberOfPairsOfCards: 3, color: Color.yellow),
        Theme(name: "Dancing", emojis: ["💃🏾", "🕺🏾", "🩰", "👯‍♂️", "👨🏾‍🎤", "🎶"], numberOfPairsOfCards: nil, color: Color.purple),
    ]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        theme = EmojiMemoryGame.themes[Int.random(in: 0..<EmojiMemoryGame.themes.count)]
        var emojis = theme!.emojis
        emojis = emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme!.numberOfPairsOfCardsToShow) { pairIndex in
            return emojis[pairIndex]
        }
    }
        
    
    // MARK: - Access to the Model
    var score: Int {
        model.score
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    

    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
        print(model)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    struct Theme {
        var name: String
        var emojis: Array<String>
        var numberOfPairsOfCards: Int?
        var numberOfPairsOfCardsToShow: Int {
            numberOfPairsOfCards ?? Int.random(in: 2..<emojis.count)
        }
        var color: Color
    }
}
