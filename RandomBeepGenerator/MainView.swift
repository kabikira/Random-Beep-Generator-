//
//  MainView.swift
//  RandomBeepGenerator
//
//  Created by koala panda on 2022/12/17.
//

import SwiftUI
import AudioKit

class OscillatorConductor {
    let osc = PlaygroundOscillator()
    let engine = AudioEngine()
    
    func playOsc() {
        engine.output = osc
        try! engine.start()
        osc.play()
        while true {
            osc.frequency = Float.random(in: 200 ... 2200)
            osc.amplitude = Float.random(in: 0.0 ... 0.3)
            usleep(100_000)
        }
    }
}


struct MainView: View {
    var oscillator = OscillatorConductor()
    
    var body: some View {
        VStack {
            Button("OscPlay") {
                oscillator.playOsc()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
