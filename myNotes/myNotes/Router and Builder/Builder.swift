//
//  Builder.swift
//  myNotes
//
//  Created by Полищук Александр on 11.01.2023.
//

import Foundation
import UIKit

protocol Builder {
    func createInitialView(router: Router) -> UIViewController
    func createNewNoteView(router: Router) -> UIViewController
    func createChosenNoteView(with model: Notes, router: Router) -> UIViewController
}

class BuilderImplementation: Builder {
    
    func createInitialView(router: Router) -> UIViewController {
        let viewModel = NotesViewModelImplementation(router: router)
        let viewController = NotesViewController(notesViewModel: viewModel)
        return viewController
    }
    
    func createNewNoteView(router: Router) -> UIViewController {
        let viewModel = DetailNoteViewModelImplementation(router: router)
        let viewController = DetailNoteViewController(viewModel: viewModel)
        return viewController
    }
    
    func createChosenNoteView(with model: Notes, router: Router) -> UIViewController {
        let viewModel = DetailNoteViewModelImplementation(router: router)
        let viewController = DetailNoteViewController(viewModel: viewModel)
        viewController.configureChosenNote(with: model)
        return viewController
    }
    

}
