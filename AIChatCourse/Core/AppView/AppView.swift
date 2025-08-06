//
//  AppView.swift
//  AIChatCourse
//
//  Created by Jocelyn Icaza on 8/6/25.
//

import SwiftUI
struct AppView: View {
    @AppStorage("showTabbarView") var showTabBar: Bool = false
    var body: some View {
        AppViewBuilder(
            showTabBar: showTabBar,
            tabbarView: {
                ZStack {
                    Color.red.ignoresSafeArea()
                    Text("Tab bar")
                }
            },
            onboardingView: {
                ZStack {
                    Color.blue.ignoresSafeArea()
                    Text("Onboarding")
                }
            }
        )
    }
}

#Preview("Tabbar") {
    AppView(showTabBar: true)
}

#Preview("Onboarding") {
    AppView(showTabBar: false)
}
