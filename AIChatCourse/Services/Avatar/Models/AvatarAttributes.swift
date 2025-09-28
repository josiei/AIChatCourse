//
//  AvatarAttributes.swift
//  AIChatCourse
//
//  Created by Jocelyn Icaza on 9/13/25.
//

enum CharacterOption: String, CaseIterable, Hashable {
    case man, woman, alien, dog, cat
    
    static var `default`: Self {
        .man
    }
    
    var plural: String {
        switch self {
        case .man:
            return "men"
        case .woman:
            return "women"
        case .alien:
            return "aliens"
        case .dog:
            return "dogs"
        case .cat:
            return "cats"
        }
    }
    
    var startsWithVowel: Bool {
        switch self {
        case .alien:
            return true
        default:
            return false
        }
    }
}

enum CharacterAction: String, CaseIterable, Hashable {
    case smiling, studying, eating, shopping, crying, fighting, walking, relaxing, sitting, drinking
    
    static var `default`: Self {
        .smiling
    }
}

enum CharacterLocation: String, CaseIterable, Hashable {
    case park, mall, museum, city, dessert, forrest, space
    
    static var `default`: Self {
        .park
    }
}

struct AvatarDescriptionBuilder {
    let characterOption: CharacterOption
    let characterAction: CharacterAction
    let characterLocation: CharacterLocation
    
    init(characterOption: CharacterOption, characterAction: CharacterAction, characterLocation: CharacterLocation) {
        self.characterOption = characterOption
        self.characterAction = characterAction
        self.characterLocation = characterLocation
    }
    
    init(avatar: AvatarModel) {
        self.characterOption = avatar.characterOption ?? .default
        self.characterAction = avatar.characterAction ?? .default
        self.characterLocation = avatar.characterLocation ?? .default
    }
    
    var characterDescription: String {
        let prefix = characterOption.startsWithVowel ? "An" : "A"
        return "\(prefix) \(characterOption.rawValue) that is \(characterAction.rawValue) in the \(characterLocation.rawValue)"
    }
}
