//
//  AppNoteView.swift
//  firebaseApp
//
//  Created by Chmil Oleksandr on 01.02.2025.
//

import UIKit

class AppNoteView: UIViewController {
    private var viewBuilder = ViewBuilder()
    private var noteService = NoteService()
    var note: Note?
    var image: UIImage?
    
    lazy var noteHeader = viewBuilder.createTextField(frame: CGRect(x: 30, y: 160, width: view.frame.width - 60, height: 50), placeholder: "Header")
    
    lazy var noteText: UITextView = {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 10
        return $0
    }(UITextView(frame: CGRect(x: 30, y: noteHeader.frame.maxY + 30, width: view.frame.width - 60, height: 100)))
    
    lazy  var saveBtn = viewBuilder.createButton(frame: CGRect(x: 30, y: view.frame.height - 100, width: view.frame.width - 60, height: 50), action: saveAction, title: note != nil ? "Update" : "Save", isMainBtn: true)
    
    lazy var saveAction = UIAction {[weak self] _ in
        guard let self = self else { return }
        let header = noteHeader.text ?? ""
        let noteText = noteText.text ?? ""
        let noteItem = Note(header: header, note: noteText, date: Date(), image: nil)
        
        if note == nil {
            noteService.createNote(note: noteItem) { result in
                switch result {
                case .success(let isAdd):
                    if isAdd {
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let failure):
                    print(failure)
                    
                }
            }
        } else {
            noteService.updateNote(noteId: note!.id, note: noteItem) { isAdd in
                if isAdd {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add note"
        view.addSubview(noteHeader)
        view.addSubview(noteText)
        view.addSubview(saveBtn)
        
        noteHeader.text = note?.header
        noteText.text = note?.note  

    }
    



}
