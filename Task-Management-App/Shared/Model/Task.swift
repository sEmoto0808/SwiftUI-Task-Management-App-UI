//
//  Task.swift
//  Task-Management-App (iOS)
//
//  Created by Sho Emoto on 2022/01/12.
//

import Foundation

// Task Model
struct Task: Identifiable {
    let id = UUID().uuidString
    let title: String
    let description: String
    let date: Date
}
