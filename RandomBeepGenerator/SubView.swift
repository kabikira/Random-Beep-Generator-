//
//  SubView.swift
//  RandomBeepGenerator
//
//  Created by koala panda on 2022/12/18.
//

import SwiftUI

struct SubView: View {
    var generator = SignalGenerator()
    
    var body: some View {
        VStack {
            Button("play") {
                //                while true {
                //                    generator.signalPlay()
                //                }
                let timer = Timer
                    .scheduledTimer(withTimeInterval: 0.01, repeats: true
                    ) { _ in
                        generator.signalPlay()
                        
                    }
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    timer.invalidate()
                }
                
            }
        }
    }
}

struct SubView_Previews: PreviewProvider {
    static var previews: some View {
        SubView()
    }
}
