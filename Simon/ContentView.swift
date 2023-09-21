//
//  ContentView.swift
//  Simon
//
//  Created by Josh Madison on 9/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var colorDisplay = [ColorDisplay(color: .green), ColorDisplay(color: .red), ColorDisplay(color: .yellow), ColorDisplay(color: .blue)]
    @State private var flash = [false, false, false, false]
    var body: some View {
        VStack {
            Text("Simon")
                
            HStack {
                colorDisplay[0]
                colorDisplay[1]
            }
            HStack {
                colorDisplay[2]
                colorDisplay[3]
            }
        }
        .padding()
        .preferredColorScheme(.dark)
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
