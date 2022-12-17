//
//  MainView.swift
//  RandomBeepGenerator
//
//  Created by koala panda on 2022/12/17.
//

import SwiftUI
import AudioKit

class NoiseConductor {
    let noise = PlaygroundNoiseGenerator()
    let engine = AudioEngine()
    func playNoise() {
        engine.output = noise
        try! engine.start()
        noise.play()
        while true {
            noise.amplitude = Float.random(in: -1 ... 1)
            usleep(100_000)
        }
    }
}

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
    var noise = NoiseConductor()
    var body: some View {
        VStack {
            Button("OscPlay") {
                oscillator.playOsc()
            }
            Button("NoisePlay") {
                noise.playNoise()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
