//
//  LoadingView.swift
//  DemoUIComponents
//
//  Created by Brian on 19/08/25.
//

import SwiftUI
import Lottie

public struct LoadingView: View {
    @ObservedObject private var manager = LoadingViewManager.shared
    public var body: some View {
        if self.manager.show {
            ZStack {
                Color.black.opacity(0.1)
                    .edgesIgnoringSafeArea(.all)
                LottieView(animation: .named("Loading"))
                    .playing(loopMode: .loop)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
            }
            .transition(.opacity)
            .animation(.default, value: self.manager.show)
        }
    }
}

final class LoadingViewManager: ObservableObject {
    @MainActor static let shared = LoadingViewManager()
    @Published var show: Bool = false
    private init() { }
}

public struct ContentLoadingView: View {
    public var body: some View {
        HStack {
            Spacer()
            LottieView(animation: .named("Loading"))
                .playing(loopMode: .loop)
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
