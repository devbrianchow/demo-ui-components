//
//  TabView.swift
//  DemoUIComponents
//
//  Created by Brian on 23/07/25.
//

import SwiftUI

public struct TabItemData {
    let view: AnyView
    let iconName: String
    let title: String
    
    public init<V: View>(view: V, iconName: String, title: String) {
        self.view = AnyView(view)
        self.iconName = iconName
        self.title = title
    }
}

public struct TabBar: View {
    private let tabs: [TabItemData]
    
    @Binding private var selectedIndex: Int

    public var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
                tab.view
                    .tag(index)
                    .tabItem {
                        Image(systemName: tab.iconName)
                        Text(tab.title)
                    }
            }
        }
    }
    
    public init(tabs: [TabItemData], selectedIndex: Binding<Int>) {
        self.tabs = tabs
        self._selectedIndex = selectedIndex
    }
}

#if DEBUG
struct TabView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var selectedIndex: Int = 0

        var body: some View {
            let tabs = [
                TabItemData(view: FirstView(), iconName: "film", title: "Películas"),
                TabItemData(view: SecondView(), iconName: "star", title: "Favoritos")
            ]

            VStack {
                TabBar(tabs: tabs, selectedIndex: $selectedIndex)
            }
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }

    struct FirstView: View {
        var body: some View {
            Text("Películas")
        }
    }

    struct SecondView: View {
        var body: some View {
            Text("Favoritos")
        }
    }
}
#endif
