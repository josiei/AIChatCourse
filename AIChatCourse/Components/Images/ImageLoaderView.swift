//
//  ImageLoaderView.swift
//  AIChatCourse
//
//  Created by Jocelyn Icaza on 8/7/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    var urlString: String = Constants.randomImage
    var resizingMode: ContentMode = .fill
    var forceTransitionAnimation: Bool = false
    var body: some View {
        /// Rectangle with overlay prevents common bug, where image extends past frame
        Rectangle()
            .opacity(0.001)
            .overlay {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
                    .allowsHitTesting(false) /// Any image extending past the frame will not be tappable
            }
            .clipped()
            .ifSatisfiedCondition(forceTransitionAnimation) { content in
                content
                    .drawingGroup()
            }

    }
}

#Preview {
    ImageLoaderView()
        .frame(width: 100, height: 200)
}
