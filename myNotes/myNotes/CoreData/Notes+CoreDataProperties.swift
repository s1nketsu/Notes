//
//  Notes+CoreDataProperties.swift
//  myNotes
//
//  Created by Полищук Александр on 11.01.2023.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var title: String?
    @NSManaged public var note: String?

}

extension Notes : Identifiable {

}
