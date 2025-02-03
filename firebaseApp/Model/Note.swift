//
//  Note.swift
//  firebaseApp
//
//  Created by Chmil Oleksandr on 31.01.2025.
//

import Foundation

struct Note: Identifiable {
    var id: String = UUID().uuidString
    let header: String
    let note: String
    let date: Date?
    let image: String?
}
