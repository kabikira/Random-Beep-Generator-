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
        let timer = Timer
            .scheduledTimer(
                withTimeInterval: 0.1,
                repeats: true
            ) { _ in
                print("NoisePlay")
                self.noise.amplitude = Float.random(in: -1 ... 1)
            }

        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            timer.invalidate()
            self.noise.stop()
            print("NoiseStop")
        }
    
    }
    func stopNoise() {
        noise.stop()
    }
}

class OscillatorConductor {
    let osc = PlaygroundOscillator()
    let engine = AudioEngine()
    var stopTime: Double = 10
    
    func playOsc() {
        engine.output = osc
        try! engine.start()
        osc.play()
        let timer = Timer
            .scheduledTimer(
                withTimeInterval: 0.1, repeats: true
            ) { _ in
                print("Oscplay")
                self.osc.frequency = Float.random(in: 200 ... 800)
                self.osc.amplitude = Float.random(in: 0 ... 0.3)
            }
        DispatchQueue.main.asyncAfter(deadline: .now() + self.stopTime) {
            timer.invalidate()
            self.osc.stop()
            print("OscStop")
        }
        
    }
    func stopOsc() {
        osc.stop()
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
            Button("OscStop") {
                oscillator.stopOsc()
            }
            Button("NoiseStop") {
                noise.stopNoise()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
