//
//  Card.swift
//  DemoUIComponents
//
//  Created by Brian on 23/07/25.
//

import SwiftUI

public struct CardView: View {
    private var imageUrlString: String
    private var imageUrl: URL? {
        URL(string: imageUrlString)
    }
    private var cardTitle: String = ""
    private var cardSubTitle: String = ""
    private var cardHeight: CGFloat = 225
    private var cornerRadius: CGFloat = 12
    
    public var body: some View {
        HStack(spacing: 0) {
            AsyncImageCardView(url: imageUrl, cardHeight: cardHeight)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(cardTitle)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(cardSubTitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: cardHeight)
        .background(.white)
        .cornerRadius(cornerRadius)
        .shadow(color: Color.black.opacity(0.05), radius: cornerRadius/3, x: 0, y: 2)
    }
    
    public init(imageUrlString: String, cardTitle: String, cardSubTitle: String) {
        self.imageUrlString = imageUrlString
        self.cardTitle = cardTitle
        self.cardSubTitle = cardSubTitle
    }
}

#if DEBUG
struct CardView_Preview: PreviewProvider {
    static var previews: some View {
        CardView(
            imageUrlString: "https://image.tmdb.org/t/p/w220_and_h330_face/5hlNv3Kd9xovvSgrslWhMriGpZ8.jpg",
            cardTitle: "Title",
            cardSubTitle: "Subtitle")
    }
}
#endif
