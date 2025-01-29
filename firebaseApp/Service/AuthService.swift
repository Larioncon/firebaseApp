//
//  AuthService.swift
//  firebaseApp
//
//  Created by Chmil Oleksandr on 27.01.2025.
//

import UIKit
import FirebaseAuth
import Firebase

class AuthService {
    func createNewUser(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, err in
            guard let self = self else { return }
            guard err == nil else {
                print(err!)
                completion(.failure(err!))
                return
            }
            result?.user.sendEmailVerification()
            signOut()
            completion(.success(true))
        }
    }
    
    func signIn(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { [weak self] result, err in
            guard let self = self else { return }
            guard err == nil else {
                print(err!)
                completion(.failure(err!))
                return
            }
            guard let user = result?.user else {
                completion(.failure(SignInError.invalidUser))
                return
            }
            if !user.isEmailVerified {
                completion(.failure(SignInError.notVerified))
                signOut()
                return
            }
            completion(.success(true))
        }
    }
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func isLogin() -> Bool {
        if let _ = Auth.auth().currentUser {
            return true
        }
        return false
    }
}


enum SignInError: Error {
    case invalidUser
    case notVerified
}
