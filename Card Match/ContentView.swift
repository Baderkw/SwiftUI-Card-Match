
//
//  ContentView.swift
//  Card Match
//
//  Created by Bader Alawadh on 6/27/20.
//  Copyright © 2020 Bader Alawadh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var indexs = [[0, 1, 2, 3],
                         [0, 1, 2, 3],
                         [4, 5, 6, 7],
                         [4, 5, 6, 7]]
    
    @State var chosenCards = [Int]()
    
    var body: some View {
        
        VStack(alignment: .leading) {

            ForEach(0 ..< self.indexs.count) { row in
                HStack {
                    Spacer()
                    ForEach(0 ..< self.indexs[0].count) { item in
                        cardView(index: self.$indexs[row][item], chosenCards: self.$chosenCards)
                    }
                    Spacer()
                }
            }.padding([.top], 5)
            
            Spacer()
        }
        .onAppear {
            self.createCardsIndex()
        }
        
    }
    
    func createCardsIndex() {
        let numberOfCards = self.indexs[0].count * self.indexs.count
        var cardsIndex = [Int]()
        
        for i in 0 ..< (numberOfCards / 2) {
            cardsIndex.append(i)
        }
        
        cardsIndex += cardsIndex
        //cardsIndex.shuffle()
        
        var k = 0
        for x in 0 ..< self.indexs.count {
            for i in 0 ..< self.indexs[0].count {
                self.indexs[x][i] = cardsIndex[k]
                k += 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct cardView: View {
    
    @Binding var index: Int
    @Binding var chosenCards: [Int]
    
    @State var isSelected = false
    
    
    var body: some View {
        
        Button(action: {
            self.chosenCards.append(self.index)
            if self.chosenCards.contains(self.index) {
                self.isSelected = true
            }
            if self.chosenCards.count == 2 {
                self.checkMatch()
            }
            print(self.chosenCards)
        }) {
            Image("\( self.isSelected && self.chosenCards.contains(self.index) ? String(self.index) : "back")")
                .resizable()
                .scaledToFit()
                .frame(height: 170)
            
        }.buttonStyle(PlainButtonStyle())
    }
    
    func checkMatch() {
        if chosenCards[0] == chosenCards[1] {
            self.chosenCards.removeAll()
            print("pair found !")
            
        }else if chosenCards[0] != chosenCards[1] {
            self.isSelected = false
            self.chosenCards.removeAll()
        }
    }
}
