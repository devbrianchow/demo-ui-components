//
//  TabView.swift
//  DemoUIComponents
//
//  Created by Brian on 23/07/25.
//

import SwiftUI

struct TabItemData: Identifiable {
    let id = UUID()
    let view: AnyView
    let iconName: String
    let title: String
    
    init<V: View>(view: V, iconName: String, title: String) {
        self.view = AnyView(view)
        self.iconName = iconName
        self.title = title
    }
}

struct TabBar: View {
    private let tabs: [TabItemData]
    
    @State private var selectedTabId: UUID

    var body: some View {
        TabView(selection: $selectedTabId) {
            ForEach(tabs) { tab in
                tab.view
                    .tag(tab.id)
                    .tabItem {
                        Image(systemName: tab.iconName)
                        Text(tab.title)
                    }
            }
        }
    }
    
    init(tabs: [TabItemData], initialTabId: UUID? = nil) {
        self.tabs = tabs
        _selectedTabId = State(initialValue: initialTabId ?? tabs.first!.id)
    }
}

#if DEBUG
struct TabView_Preview: PreviewProvider {
    static var previews: some View {
        let tabs: [TabItemData] = [
            TabItemData(view: FirstView(), iconName: "square.grid.2x2", title: "Peliculas"),
            TabItemData(view: SecondView(), iconName: "star", title: "Favoritos")
        ]
        TabBar(tabs: tabs)
    }
}
struct FirstView: View {
    var body: some View {
        Text("FirstView")
    }
}

struct SecondView: View {
    var body: some View {
        Text("SecondView")
    }
}
#endif
