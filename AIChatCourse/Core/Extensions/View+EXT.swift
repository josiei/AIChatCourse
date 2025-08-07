//
//  View+EXT.swift
//  AIChatCourse
//
//  Created by Jocelyn Icaza on 8/6/25.
//
import SwiftUI
extension View {
    func callToActionButton() -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.accent)
            .cornerRadius(16)
    }
    
    func tappableBackground() -> some View {
        self
            .background(Color.black.opacity(0.001))
    }
}
