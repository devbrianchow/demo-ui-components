//
//  GenericList.swift
//  DemoUIComponents
//
//  Created by Brian on 19/08/25.
//

import SwiftUI

public struct GenericList<Item: Identifiable, Cell: View>: View {
    
    private let columns = [GridItem(.flexible(), spacing: 0)]
    
    private var status: GenericListStatus<Item> = .loading
    private let cell: (Item) -> Cell
    
    private var emptyView: ((String) -> AnyView)?
    private var errorView: ((String) -> AnyView)?
    private var loadingView: (() -> AnyView)?
    private var isRefreshable: (() -> Void)?
    private var onCellSelected: ((Item) -> Void)?
    
    public init(status: GenericListStatus<Item>, cell: @escaping (Item) -> Cell) {
        self.status = status
        self.cell = cell
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                Group {
                    switch self.status {
                    case .loading:
                        self.loadingView?()
                            .transition(.opacity)
                    case .empty(let message):
                        self.emptyView?(message)
                            .frame(height: proxy.size.height)
                            .transition(.opacity)
                    case .error(let message):
                        self.errorView?(message)
                            .transition(.opacity)
                    case .data(let items):
                        LazyVGrid(columns: self.columns, spacing: 14) {
                            ForEach(items) { item in
                                self.cell(item)
                                    .onTapGesture {
                                        self.onCellSelected?(item)
                                    }
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 14)
                        .transition(.opacity)
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: self.status)
            }
            .ignoresSafeArea(.container, edges: .bottom)
            .conditionalRefreshable(self.isRefreshable)
        }
    }
    
    public func onCellSelected(_ value: ((Item) -> Void)?) -> Self {
        var view = self
        view.onCellSelected = value
        return view
    }
    
    public func emptyView(_ value: @escaping (String) -> some View) -> Self {
        var view = self
        view.emptyView = { AnyView(value($0)) }
        return view
    }
    
    public func errorView(_ value: @escaping (String) -> some View) -> Self {
        var view = self
        view.errorView = { AnyView(value($0)) }
        return view
    }
    
    public func loadingView(_ value: @escaping () -> some View) -> Self {
        var view = self
        view.loadingView = { AnyView(value()) }
        return view
    }
    
    public func isRefreshable(_ value: (() -> Void)?) -> Self {
        var view = self
        view.isRefreshable = value
        return view
    }
}

fileprivate extension View {
    @ViewBuilder
    func conditionalRefreshable(_ action: (() -> Void)?) -> some View {
        if let action = action {
            self.refreshable { action() }
        } else {
            self
        }
    }
}

public enum GenericListStatus<Item: Identifiable>: Equatable {
    case loading
    case empty(message: String)
    case error(message: String)
    case data(items: [Item])
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
             (.empty, .empty),
             (.error, .error),
             (.data, .data): true
        default: false
        }
    }
}

