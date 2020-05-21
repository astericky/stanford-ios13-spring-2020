//
//  ContentView.swift
//  Memorize
//
//  Created by Chris Sanders on 5/20/20.
//  Copyright © 2020 Chris Sanders. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                    .frame(width: 30, height: 45)
                    .onTapGesture {
                        self.viewModel.choose(card: card)
                    }
            }
        }
            .padding()
            .foregroundColor(Color.orange)
            .font(viewModel.cards.count < 5 ? .largeTitle : .body)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
