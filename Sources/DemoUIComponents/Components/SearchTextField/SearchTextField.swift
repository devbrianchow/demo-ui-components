//
//  SearchTextField.swift
//  DemoUIComponents
//
//  Created by Brian on 20/08/25.
//

import SwiftUI

public struct SearchTextField: View {
    @Binding var text: String
    private var placeholder: String = ""

    public var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)

                TextField(self.placeholder, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding()
        }
    }
    
    public init(text: Binding<String>, placeholder: String) {
        _text = text
        self.placeholder = placeholder
    }
}

#Preview {
    SearchTextField(text: .constant(""), placeholder: "Buscar...")
}
