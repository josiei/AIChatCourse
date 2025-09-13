//
//  CreateAvatarView.swift
//  AIChatCourse
//
//  Created by Jocelyn Icaza on 9/12/25.
//

import SwiftUI

struct CreateAvatarView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var avatarName: String = ""
    @State private var characterOption: CharacterOption = .default
    @State private var characterAction: CharacterAction = .default
    @State private var characterLocation: CharacterLocation = .default
    @State private var isGenerating: Bool = false
    @State private var generatedImage: UIImage?
    @State private var isSaving: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                nameSection
                attributesSection
                imageSection
                saveSection
            }
            .navigationTitle("Create Avatar")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
            }
        }
    }
    
    private var backButton: some View {
        Image(systemName: "xmark")
            .font(.title2)
            .fontWeight(.semibold)
            .anyButton(.plain) {
                onBackButtonPressed()
            }
    }
    
    private var saveSection: some View {
        Section {
            AsyncCallToActionButton(
                isLoading: isSaving,
                title: "Save",
                action: onSavePressed
            )
            .removeListRowFormatting()
            .padding(.top, 24)
            .opacity(generatedImage == nil ? 0.5 : 1)
            .disabled(generatedImage == nil)
        }
    }
    
    private var imageSection: some View {
        Section {
            HStack(alignment: .top, spacing: 8) {
                ZStack {
                    Text("Generate Image")
                        .underline()
                        .foregroundStyle(.accent)
                        .anyButton(.plain) {
                            onGenerateImage()
                        }
                        .opacity(isGenerating ? 0 : 1)
                    
                    ProgressView()
                        .opacity(isGenerating ? 1 : 0)
                }
                .disabled(isGenerating || avatarName.isEmpty)
                
                Circle()
                    .fill(Color.secondary.opacity(0.3))
                    .overlay {
                        ZStack {
                            if let generatedImage {
                                Image(uiImage: generatedImage)
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                    }
                    .clipShape(Circle())
            }
            .removeListRowFormatting()
        }
    }
    
    private var attributesSection: some View {
        Section {
            Picker(selection: $characterOption) {
                ForEach(CharacterOption.allCases, id: \.self) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            } label: {
                Text("is a...")
            }
            
            Picker(selection: $characterAction) {
                ForEach(CharacterAction.allCases, id: \.self) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            } label: {
                Text("that is...")
            }
            
            Picker(selection: $characterLocation) {
                ForEach(CharacterLocation.allCases, id: \.self) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            } label: {
                Text("in the...")
            }

        } header: {
            Text("Attributes")
        }
    }
    
    private var nameSection: some View {
        Section {
            TextField("Player 1", text: $avatarName)
        } header: {
            Text("Name your avatar*")
        }
    }
    
    private func onBackButtonPressed() {
        dismiss()
    }
    
    private func onGenerateImage() {
        isGenerating = true
        
        Task {
            try? await Task.sleep(for: .seconds(3))
            generatedImage = UIImage(systemName: "star.fill")
            isGenerating = false
        }
    }
    
    private func onSavePressed() {
        isSaving = true
        
        Task {
            try? await Task.sleep(for: .seconds(3))
            dismiss()
            isSaving = false
        }
    }
}

#Preview {
    CreateAvatarView()
}
