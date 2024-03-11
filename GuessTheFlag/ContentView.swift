//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Prathamesh on 3/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var alertTitle = ""
    @State private var score = 0
    
    private var resetTitle = "Do you want to reset"
    @State private var resetFlag = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap me")
                            .foregroundStyle(.secondary)
                            .font(.title.weight(.medium))
                        Text("\(countries[correctAnswer])")
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.heavy))
                        
                        ForEach(0..<3) { number in
                            Button{
                                flagTapped(number)
                                
                            } label: {
                                FlagImage(flagname: countries[number])
                            }
                            
                        }
                    }
                    .innerStackStyle()
                    
                    // If not added in view extension
//                    .modifier(innerStackView())
                }

                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Button {
                    resetFlag = true
                } label: {
                    Text("Reset")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                }
                .buttonStyle(.bordered)
                .background(.blue)
                .bold()
                .buttonBorderShape(.circle)
                .shadow(radius: 10)
                
                
            }
            .padding()
            .alert(alertTitle, isPresented: $showingScore) {
                Button("Continue",action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
            
            .alert(isPresented: $resetFlag) {
                Alert(
                    title: Text(resetTitle),
                    message: Text("Your current total score is \(score)"),
                    primaryButton: .destructive(Text("Yes"), action: {
                        resetGame()
                    }),
                    secondaryButton: .default(Text("No")) //<-- use default here
                )
            }
        }
    }
    
    func flagTapped(_ number:Int) {
        if number == correctAnswer {
            alertTitle = "Yor are Correct :) !!"
            score = score + 1
        } else {
            alertTitle = "Try again :) !!"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        score = 0
        askQuestion()
    }
}

struct FlagImage: View {
    var flagname: String
    
    var body: some View {
        Image(flagname)
            .clipShape(.buttonBorder)
            .shadow(radius: 10)
    }
}

struct innerStackView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
    }
}

extension View {
    func innerStackStyle() -> some View {
        modifier(innerStackView())
    }
}

#Preview {
    ContentView()
}


//            LinearGradient(colors: [.red,.green], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()


// Learning
//        ZStack {
//            VStack(spacing: 0){
//                Color.red
//                Color.blue
//            }
//            .ignoresSafeArea()
//            VStack {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundStyle(.tint)
//                Text("Hello, world!")
//            }
//            .padding(50)
//            .foregroundStyle(.secondary)
//            .background(.ultraThinMaterial)
//        }

//        LinearGradient(colors: [.red,.green], startPoint: .leading, endPoint: .trailing)
//            .ignoresSafeArea()
//
//        LinearGradient(stops: [
//            Gradient.Stop(color: .white, location: 0.25),
//            Gradient.Stop(color: .black, location: 0.55),
//        ], startPoint: .top, endPoint: .bottom)
//
//        LinearGradient(stops: [
//            .init(color: .orange, location: 0.45),
//            .init(color: .purple, location: 0.55),
//        ], startPoint: .top, endPoint: .bottom)
//
//        RadialGradient(colors: [.blue, .yellow], center: .center, startRadius: 20, endRadius: 200)
//
//        AngularGradient(colors: [.red, .yellow, .green, .blue, .purple], center: .center)
