//
//  UserData.swift
//  firebaseApp
//
//  Created by Chmil Oleksandr on 27.01.2025.
//

import Foundation

struct UserData: Identifiable {
    var id: String = UUID().uuidString
    let email: String
    let password: String
    var name: String? = nil
    
 
}
