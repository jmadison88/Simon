//
//  ContentView.swift
//  Simon
//
//  Created by Josh Madison on 9/13/23.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var flash = [false, false, false, false]
    @State private var index = 0
    @State private var playerTurn = false
    @State private var messsage = ""
    @State private var gameOver = true
    @State var speed = 0.5
    @State var highScore = 0
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State var audioPlayer: AVAudioPlayer!
    var colorDisplay = [TapColor(color: .green), TapColor(color: .red), TapColor(color: .yellow), TapColor(color: .blue)]
    var body: some View {
        VStack {
            Text("simon")
                .font(.custom("Impact", size: 72))
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(100), spacing:
                                                            
                                                            15), count: 2), spacing: 15, content: {
                
                ForEach(0..<4) { i in
                    colorDisplay[i]
                        .opacity(flash[i] ? 1 : 0.4)
                        .onTapGesture {
                            playSound(sound: String(i))
                            if playerTurn {
                                flashColor(index: i)
                                if sequence[index] != i {
                                    message = "You lose"
                                    gameOver = true
                                    playSound(sound: "lose")
                                    
                                }
                                else {
                                    index += 1
                                    
                                    if index > highScore {
                                        highScore = index
                                        
                                        // playSound(sound: "highscore")
                                        
                                    }
                                    if index == sequence.count {
                                        index = 0
                                        
                                        playerTurn = false
                                        
                                        addToSequence()
                                    }
                                }
                            }
                        }
                }
            })
            Text(message)
                .font(.custom("Impact", size: 36))
                .padding()
                .onTapGesture {
                    if message == "Start" {
                        playSound(sound: "start")
                        gameOver = false
                        message = " "
                        
                    }
                    else if message == "You lose" {
                        restart()
                    }
                }
            Text("High Score: \(highScore)")
        }
        .preferredColorScheme(.dark)
        .onAppear(perform: {
            restart()
        })
        .onReceive(timer, perform: { _ in
            if !gameOver && !playerTurn {
                if index < sequence.count {
                    message = " "
                    
                    flashColor(index: sequence[index])
                    playSound(sound: String(sequence[index]))
                    index += 1
                }
                else {
                    playerTurn.toggle()
                    message = "Your turn"
                    index = 0
                    
                }
            }
        })
    }
    
    func flashColorDisplay(index: Int) {
        flash[index].toggle()
        withAnimation(.easeInOut(duration: 0.5)) {
            flash[index].toggle()
        }
    }
}

struct ColorDisplay: View {
    let color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(color)
            .frame(width: 100, height: 100, alignment: .center)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
