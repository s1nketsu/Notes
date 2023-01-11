//
//  NotesViewModel.swift
//  myNotes
//
//  Created by Полищук Александр on 11.01.2023.
//

import Foundation
import CoreData

protocol NotesViewModel {
    var notes: [Notes] { get set }
    func addAnInitNote()
    func openNote(note: Notes)
    func deleteNote(note: Notes)
    func addNote()
    func reloadNotes()
}

final class NotesViewModelImplementation: NotesViewModel {
    
    private var coreData = CoreDataManagerImplementation.shared
    private var router: Router!
    
    
    var notes: [Notes] = []
    
    init(router: Router!) {
        self.router = router
        let request = Notes.fetchRequest()
        notes = try! coreData.persistentContainer.viewContext.fetch(request)
    }
    
    func addAnInitNote() {
        if UserDefaults.standard.value(forKey: "launchCount") == nil {
            let entity = Notes(context: coreData.persistentContainer.viewContext)
            entity.title = "Hello"
            entity.note = "This is my little Notes app for CFT"
            coreData.saveContext()
            UserDefaults.standard.set(1, forKey: "launchCount")
        }
    }
    
    func reloadNotes() {
        let request = Notes.fetchRequest()
        notes = try! coreData.persistentContainer.viewContext.fetch(request)
    }
    
    func addNote() {
        router.openNewNote()
    }
    
    func openNote(note: Notes) {
        router.openSelectedNote(note: note)
    }
    
    func deleteNote(note: Notes) {
        coreData.persistentContainer.viewContext.delete(note)
        coreData.saveContext()
        reloadNotes()
        print("note deleted")
    }
}
