//
//  DetailNoteViewModel.swift
//  myNotes
//
//  Created by Полищук Александр on 11.01.2023.
//

import Foundation

protocol DetailNoteViewModel {
    var isEditing: Bool { get set }
    var router: Router! { get set }
    var currentNote: Notes? { get set }
    func saveNote(with title: String, note: String)
    func saveEditableNote(with title: String, note: String)
    func saveNewNote(with title: String, note: String)
}

final class DetailNoteViewModelImplementation: DetailNoteViewModel {
    
    private var coreData = CoreDataManagerImplementation.shared
    var router: Router!
    var isEditing: Bool = false
    var currentNote: Notes?
    
    init(router: Router!) {
        self.router = router
    }
    
    func saveEditableNote(with title: String, note: String) {
        let editNote = currentNote
        editNote?.title = title
        editNote?.note = note
        coreData.saveContext()
    }
    
    func saveNewNote(with title: String, note: String) {
        let entity = Notes(context: coreData.persistentContainer.viewContext)
        entity.title = title
        entity.note = note
        coreData.saveContext()
    }
    
    func saveNote(with title: String, note: String) {
        if isEditing {
            saveEditableNote(with: title, note: note)
        } else {
            saveNewNote(with: title, note: note)
        }
    }
}
