//
//  Binding+EXT.swift
//  AIChatCourse
//
//  Created by Jocelyn Icaza on 9/26/25.
//
import Foundation
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
