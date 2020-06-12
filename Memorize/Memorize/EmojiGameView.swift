//
//  EmojiGameView.swift
//  Memorize
//
//  Created by Chris Sanders on 5/20/20.
//  Copyright © 2020 Chris Sanders. All rights reserved.
//

import SwiftUI

struct EmojiGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            header
            GridView(viewModel: viewModel)
            footer
        }
    }
    
    private var shouldShowHeaderView: Bool {
        if let themeName = EmojiMemoryGame.theme?.name {
            return !themeName.isEmpty
        } else {
            return false
        }
    }
    
    private var header: some View {
        Group {
            if shouldShowHeaderView {
                HeaderView(title: EmojiMemoryGame.theme!.name)
            }
        }
    }
    
    private var footer: some View {
        FooterView(viewModel: viewModel)
            .padding()
    }
}

struct HeaderView: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
        }
    }
}

struct FooterView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack {
            Text("Score: \(viewModel.score)")
            Spacer()
            Button(action: {
                self.viewModel.createNewMemoryGame()
            }) {
                Text("New Game")
            }
        }
    }
}

struct GridView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card)
                .onTapGesture {
                    self.viewModel.choose(card: card)
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(EmojiMemoryGame.theme?.color)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameView(viewModel: EmojiMemoryGame())
    }
}
