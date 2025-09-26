//
//  ChatView.swift
//  AIChatCourse
//
//  Created by Jocelyn Icaza on 9/14/25.
//

import SwiftUI

extension Binding where Value == Bool {
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}

struct AnyAppAlert: Sendable {
    var title: String
    var subtitle: String?
    var buttons: @Sendable () -> AnyView
    
    init(title: String, subtitle: String? = nil, buttons: (@Sendable () -> AnyView)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.buttons = buttons ?? {
            AnyView(
                Button("OK", action: {
                    
                })
            )
        }
    }
}

struct ChatView: View {
    @State private var chatMessages: [ChatMessageModel] = ChatMessageModel.mocks
    @State private var avatar: AvatarModel? = .mock
    @State private var currentUser: UserModel? = .mock
    @State private var textFieldText: String = ""
    @State private var showChatSettings: Bool = false
    @State private var scrollPosition: String?
    @State private var showAlert: AnyAppAlert?
    
    var body: some View {
        VStack(spacing: 0) {
            scrollViewSection
            
            textFieldSection
        }
        .navigationTitle(avatar?.name ?? "Chat")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "ellipsis")
                    .padding(8)
                    .anyButton(.plain) {
                        onChatSettingsPressed()
                    }
            }
        }
        .confirmationDialog("What would you like to do?", isPresented: $showChatSettings) {
            Button("Report User / Chat", role: .destructive) {
                
            }
            Button("Delete Chat", role: .destructive) {
                
            }
        }
        .alert(showAlert?.title ?? "", isPresented: Binding(ifNotNil: $showAlert)) {
            showAlert?.buttons()
        } message: {
            if let subtitle = showAlert?.subtitle {
                Text(subtitle)
            }
        }

    }
    
    private var textFieldSection: some View {
        TextField("Say something...", text: $textFieldText)
            .keyboardType(.alphabet)
            .autocorrectionDisabled()
            .padding(12)
            .padding(.trailing, 60)
            .overlay(
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .padding(.trailing, 4)
                    .foregroundStyle(.accent)
                    .anyButton(.plain, action: {
                        onSendMessagePressed()
                    })
                
                ,
                alignment: .trailing
            )
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color(uiColor: .systemBackground))
                    
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                }
            )
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(uiColor: .secondarySystemBackground))
    }
    
    private var scrollViewSection: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(chatMessages) { message in
                    let isCurrentUser = message.authorId == currentUser?.userId
                    ChatBubbleViewBuilder(
                        message: message,
                        isCurrentUser: isCurrentUser,
                        imageName: avatar?.profileImageName
                    )
                    .id(message.id)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .rotationEffect(.degrees(180))
        }
        .rotationEffect(.degrees(180))
        .scrollPosition(id: $scrollPosition, anchor: .center)
        .animation(.default, value: chatMessages.count)
        .animation(.default, value: scrollPosition)
    }
    
 
    private func onSendMessagePressed() {
        guard let currentUser else { return }
        let content = textFieldText
        
        do {
            try TextValidationHelper.checkIfTextIsValid(text: content)
            
            let message = ChatMessageModel(
                id: UUID().uuidString,
                chatId: UUID().uuidString,
                authorId: currentUser.userId,
                content: content,
                seenByIds: nil,
                dateCreated: .now
            )
            
            chatMessages.append(message)
            scrollPosition = message.id
            textFieldText = ""
        } catch let error {
            showAlert = AnyAppAlert(title: error.localizedDescription)
        }
    }
    
    private func onChatSettingsPressed() {
        showChatSettings = true
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
