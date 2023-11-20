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
    var colorDisplay = [TapColor(color: .green), [TapColor(color: .red), [TapColor(color: .yellow), [TapColor(color: .blue)  ]
    var body: some View {
        VStack {
            Text("Simon")
                .font(.custom("Impact", size: 72))
            HStack {
                colorDisplay[0]
                    .onTapGesture {
                        flashColorDisplay(index: 0)
                    }
                    .opacity(flash[0] ? 1 : 0.4)
                colorDisplay[1]
                    .onTapGesture {
                        flashColorDisplay(index: 1)
                    }
                    .opacity(flash[1] ? 1 : 0.4)
            }
            HStack {
                colorDisplay[2]
                    .onTapGesture {
                        flashColorDisplay(index: 2)
                    }
                    .opacity(flash[2] ? 1 : 0.4)
                colorDisplay[3]
                    .onTapGesture {
                        flashColorDisplay(index: 3)
                    }
                    .opacity(flash[3] ? 1 : 0.4)
            }
        }
        .padding()
        .preferredColorScheme(.dark)
        .onReceive(timer) { _ in
            if index < sequence.count {
                flashColorDisplay(index: sequence[index])
                index += 1
            }
            else {
               index = 0
            }
        }
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
