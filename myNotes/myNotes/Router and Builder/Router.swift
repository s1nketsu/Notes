//
//  Router.swift
//  myNotes
//
//  Created by Полищук Александр on 11.01.2023.
//

import Foundation
import UIKit

protocol Router {
    var navigationController: UINavigationController! { get set }
    var builder: Builder! { get set }
    func openInitView()
    func openNewNote()
    func openSelectedNote(note: Notes)
    func popToRoot()
}

class RouterImplementation: Router {
    
    var navigationController: UINavigationController!
    var builder: Builder!
    
    init(navigationController: UINavigationController!, builder: Builder!) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func openInitView() {
        let vc = builder.createInitialView(router: self)
        navigationController.viewControllers = [vc]
    }
    
    func openNewNote() {
        let vc = builder.createNewNoteView(router: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openSelectedNote(note: Notes) {
        let vc = builder.createNewNoteView(router: self) as! DetailNoteViewController
        vc.configureChosenNote(with: note)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popToRoot() {
        navigationController.popViewController(animated: true)
    }
}
