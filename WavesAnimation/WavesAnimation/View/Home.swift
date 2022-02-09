//
//  Home.swift
//  WavesAnimation
//
//  Created by Майлс on 09.02.2022.
//

import SwiftUI

struct Home: View {
    
    @State private var switcher: Bool = false
    
    var body: some View {
        ZStack {
            WaveForm(color: .purple.opacity(0.8), amplify: 150, isReversed: false)
            WaveForm(color: (switcher ? Color.purple : Color.cyan).opacity(0.6), amplify: 140, isReversed: true)
            
            VStack {
                HStack {
                    Text("Wave's")
                        .font(.largeTitle.bold())
                    Spacer()
                    Toggle(isOn: $switcher) {
                        Image(systemName: "eyedropper.halffull")
                            .font(.title2)
                            .padding(5)
                            .border(Color.purple, width: 2)
                            .cornerRadius(5)
                    }
                    .tint(Color.purple)
                    .toggleStyle(.button)
                }
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

//MARK: - PREVIEW
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
