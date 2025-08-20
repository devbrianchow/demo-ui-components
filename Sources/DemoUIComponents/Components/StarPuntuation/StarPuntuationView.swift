//
//  StarPuntuationView.swift
//  DemoUIComponents
//
//  Created by Brian on 20/08/25.
//

import SwiftUI

public struct StarPuntuationView: View {
    let puntuation: Double
    let iconStartFill: String = "star.fill"
    let iconStartMidFill: String = "star.leadinghalf.filled"
    let iconStartEmpty: String = "star"
    
    public var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<5) { index in
                Image(systemName: starType(index: index))
                    .foregroundColor(.yellow)
            }
        }
    }
    
    func starType(index: Int) -> String {
        let puntuationResult = puntuation - Double(index)
        
        switch puntuationResult {
        case 0.5..<1:
            return iconStartMidFill
        case 1...:
            return iconStartFill
        default:
            return iconStartEmpty
        }
    }
    
    public init(puntuation: Double) {
        self.puntuation = puntuation
    }
}

