//
//  SkeletonCardView.swift
//  DemoUIComponents
//
//  Created by Brian on 19/08/25.
//

import SwiftUI

public struct SkeletonCardView: View {
    
    private var cardHeight: CGFloat = 225
    private var cornerRadius: CGFloat = 12
    
    public init() {}
    
    public var body: some View {
        HStack(alignment: .top) {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 150, height: cardHeight)
                .cornerRadius(8)
            
            VStack(spacing: 6) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 20)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 50)
                    .padding(.top, 8)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: cardHeight)
        .background(.white)
        .cornerRadius(cornerRadius)
        .shadow(color: Color.black.opacity(0.05), radius: cornerRadius/3, x: 0, y: 2)
    }
}
