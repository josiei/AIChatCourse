//
//  ChatsView.swift
//  AIChatCourse
//
//  Created by Jocelyn Icaza on 8/6/25.
//

import SwiftUI

struct ChatsView: View {
    @State private var chats: [ChatModel] = ChatModel.mocks
    @State private var path: [NavigationPathOption] = []
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(chats) { chat in
                    ChatRowCellViewBuilder(
                        currentUserId: nil, // Add cuid
                        chat: chat,
                        getAvatar: {
                            try? await Task.sleep(for: .seconds(5))
                            return .mock
                        },
                        getLastChatMessage: {
                            try? await Task.sleep(for: .seconds(5))
                            return .mock
                        }
                    )
                    .anyButton(.highlight, action: {
                        onChatPressed(chat: chat)
                    })
                    .removeListRowFormatting()
                }
            }
            .navigationTitle("Chats")
            .navigationDestinationForCoreModule(path: $path)
        }
    }
    
    private func onChatPressed(chat: ChatModel) {
        path.append(.chat(avatarId: chat.avatarId))
    }
}

#Preview {
    ChatsView()
}
