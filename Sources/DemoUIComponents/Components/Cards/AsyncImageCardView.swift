//
//  AsyncImageCardView.swift
//  DemoUIComponents
//
//  Created by Brian on 23/07/25.
//

import SwiftUI

public struct AsyncImageCardView: View {
    let url: URL?
    let cardHeight: CGFloat
    let imageWidth: CGFloat = 150

    public var body: some View {
        Group {
            if let url {
                imageFromURL(url)
            } else {
                placeholderImage(imageDefault: "photo")
            }
        }
    }

    @ViewBuilder
    private func imageFromURL(_ url: URL) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                loadingView
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageWidth, height: cardHeight)
                    .clipped()
            case .failure:
                placeholderImage(imageDefault: "photo")
            @unknown default:
                EmptyView()
            }
        }
    }

    private var loadingView: some View {
        ProgressView()
            .frame(width: imageWidth, height: cardHeight)
            .background(Color.gray.opacity(0.2))
    }

    private func placeholderImage(imageDefault: String) -> some View {
        Image(systemName: imageDefault)
            .resizable()
            .scaledToFit()
            .frame(width: imageWidth, height: cardHeight)
            .foregroundColor(.gray)
            .background(Color.gray.opacity(0.2))
    }
    
    public init(url: URL?, cardHeight: CGFloat) {
        self.url = url
        self.cardHeight = cardHeight
    }
}

#if DEBUG
struct AsyncImageCardView_Preview: PreviewProvider {
    static var previews: some View {
        AsyncImageCardView(
            url: URL(string: "https://image.tmdb.org/t/p/w220_and_h330_face/wCJSNZcLT7EuKKW35my9VLmrkR7.jpg"),
            cardHeight: 225)
    }
}
#endif

