//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kamil Porębski on 12/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctCountry = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var showingResult = false
    @State private var scoreTitle = ""
    @State private var scoreValue = 0
    @State private var alertMessage = "Your score is 0"
    @State private var questionNumber = 1
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                HStack {
                    Text("\(questionNumber)/8")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                    .padding(.vertical, 15)
                
                VStack(spacing: 30){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctCountry])
                            .font(.largeTitle.weight(.bold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button() {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .shadow(radius: 8)
                                .clipShape(.buttonBorder)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreValue)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Spacer()
            }.padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: anotherFlags)
        } message: {
            Text(alertMessage)
        }
        .alert("Final score!", isPresented: $showingResult) {
            Button("Reset the game", action: anotherFlags)
        } message: {
            Text("Your score is: \(scoreValue)")
        }
    }
    func flagTapped(_ number:Int) {
        if number == correctCountry {
            scoreTitle = "Correct!"
            scoreValue += 1
            alertMessage = "Your score is: \(scoreValue)"
        }
        else {
            scoreTitle = "Wrong!"
            alertMessage = "That's the flag of \(countries[number])."
        }
        
        if(questionNumber<8) {
            showingScore = true
        }
        else {
            showingResult = true
        }
    }
    
    func anotherFlags() {
        countries.shuffle()
        correctCountry = Int.random(in: 0...2)
        questionNumber += 1
        
        if(questionNumber>8) {
            reset()
        }
    }
    
    func reset() {
        scoreValue = 0
        questionNumber = 1
        
    }
}

#Preview {
    ContentView()
}
