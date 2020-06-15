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
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack {
            Text("Score: \(viewModel.score)")
            Spacer()
            Button(action: {
                withAnimation(.easeInOut(duration: 2)) {
                    self.viewModel.resetGame()
                }
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
                    withAnimation(.linear(duration: 2)) {
                        self.viewModel.choose(card: card)
                    }
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
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(
                    startAngle: Angle.degrees(0 - 90),
                    endAngle: Angle.degrees(110 - 90),
                    clockwise: true
                )
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            
        }
    }
    
    // MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.6
    }
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
//        game.choose(card: game.cards[0])
        return EmojiGameView(viewModel: game)
    }
}
