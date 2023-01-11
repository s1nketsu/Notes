//
//  CoreDataManager.swift
//  myNotes
//
//  Created by Полищук Александр on 11.01.2023.
//

import Foundation
import CoreData

protocol CoreDataManager {
    var persistentContainer: NSPersistentContainer { get set }
    func saveContext()
}

class CoreDataManagerImplementation: CoreDataManager {
    
    static var shared = CoreDataManagerImplementation()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "myNotes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
