//
//  MainView.swift
//  RandomBeepGenerator
//
//  Created by koala panda on 2022/12/17.
//

import SwiftUI
import AudioKit
import AudioKitUI

//class NoiseConductor {
//    let noise = PlaygroundNoiseGenerator()
//    let engine = AudioEngine()
//    func playNoise() {
//        engine.output = noise
//        try! engine.start()
//        noise.play()
//        let timer = Timer
//            .scheduledTimer(
//                withTimeInterval: 0.1,
//                repeats: true
//            ) { _ in
//                print("NoisePlay")
//                self.noise.amplitude = Float.random(in: -1 ... 1)
//            }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            timer.invalidate()
//            self.noise.stop()
//            print("NoiseStop")
//        }
//
//    }
//    func stopNoise() {
//        noise.stop()
//    }
//}

class Conductor: ObservableObject {
    @Published var isPlaying: Bool = false
    let noise = PlaygroundNoiseGenerator()
    let osc = PlaygroundOscillator()
    let engine = AudioEngine()
    var timer :Timer?
    var stopTime: Double = 10
    
    func playNoise() {
        engine.output = noise
        try! engine.start()
        noise.play()
        print("NoisePlay")
        timer = Timer
            .scheduledTimer(withTimeInterval: 0.1, repeats: true
            ) { _ in
                
                self.noise.amplitude = Float.random(in: -1 ... 1)
            }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.timer?.invalidate()
            self.noise.stop()
            print("NoiseStop")
        }
        
    }
    func stopNoise() {
        noise.stop()
    }
    
    func playOsc() {
        self.stopTime = 10
        engine.output = osc
        try! engine.start()
        osc.play()
        print("Oscplay")
        timer = Timer
            .scheduledTimer(
                withTimeInterval: 0.1, repeats: true
            ) { _ in
                
                self.osc.frequency = Float.random(in: 200 ... 800)
                self.osc.amplitude = Float.random(in: 0 ... 0.3)
            }
        DispatchQueue.main.asyncAfter(deadline: .now() + self.stopTime) {
            self.timer?.invalidate()
            self.osc.stop()
            print("OscStop")
        }
        
    }
    func stopOsc() {
        
        osc.stop()
        
    }
    
}


struct TestView: View {
    
    @ObservedObject var conductor = Conductor()
  
    var body: some View {
        VStack {
            NodeOutputView(conductor.osc)
            
            Button("OscPlay") {
                if conductor.isPlaying == false {
                    conductor.isPlaying = true
                    conductor.stopOsc()
                } else {
                    conductor.isPlaying = false
                    conductor.playOsc()
                }
                
            }
            Button("NoisePlay") {
                conductor.playNoise()
            }
            Button("OscStop") {
                conductor.stopOsc()
            }
            Button("NoiseStop") {
                conductor.stopNoise()
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
