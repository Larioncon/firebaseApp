//
//  NoteService.swift
//  firebaseApp
//
//  Created by Chmil Oleksandr on 01.02.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class NoteService {
    //CRUD
    
    func createNote(note: Note, completion: @escaping(Result<Bool, Error>) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .document(note.id)
            .setData(["header" : note.header, "note" : note.note, "date" : Date()]) { err in
                guard err == nil else {
                    completion(.failure(err!))
                    return
                }
                completion(.success(true))
            }
    }
    
    func readNotes(completion: @escaping (Result<[Note], Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .addSnapshotListener { snpsht, err in
                guard err == nil else {
                    print(err!)
                    completion(.failure(err!))
                    return
                }
                guard let docs = snpsht?.documents else {return}
                var notes = [Note]()
                
                docs.forEach { doc in
                    let header = doc["header"] as? String
                    let noteText = doc["note"] as? String
                    let dateStamp = doc["date"] as? Timestamp
                    let date = dateStamp?.dateValue()
                    
                    let note = Note(id: doc.documentID, header: header ?? "", note: noteText ?? "", date: date ?? Date(), image: nil)
                    
                    notes.append(note)
                }
                completion(.success(notes))
            }
    }
    
    func updateNote(noteId: String, note: Note, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .document(noteId)
            .updateData(["header" : note.header, "note" : note.note, "date" : Date()]) { err in
                guard err == nil else {
                    print(err!)
                    return
                }
                completion(true)
            }
    }
    
    func deleteNote(noteId: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("notes")
            .document(noteId)
            .delete()
    }
}
