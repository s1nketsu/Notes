//
//  ViewController.swift
//  myNotes
//
//  Created by Полищук Александр on 10.01.2023.
//

import UIKit

class NotesViewController: UIViewController {
    
    private var viewModel: NotesViewModel!
    private var cellIdentifier = "identifier"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 5
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var isEmptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No Notes Yet"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(notesViewModel: NotesViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = notesViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadNotes()
        tableView.reloadData()
        checkEmptiness()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.addAnInitNote()
        setupView()
        setConstraints()
        checkEmptiness()
    }
    
    private func checkEmptiness() {
        if viewModel.notes.count == 0 {
            tableView.isHidden = true
            isEmptyLabel.isHidden = false
        } else {
            tableView.isHidden = false
            isEmptyLabel.isHidden = true
        }
    }

}

private extension NotesViewController {
    func setupView() {
        view.backgroundColor = .white
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        view.addSubview(tableView)
        view.addSubview(isEmptyLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
            isEmptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            isEmptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func addButtonTapped() {
        viewModel.addNote()
    }
}

extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NoteTableViewCell
        let note = viewModel.notes[indexPath.row]
        cell.configure(with: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.notes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = viewModel.notes[indexPath.row]
        viewModel.openNote(note: note)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = viewModel.notes[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, action in
            self.viewModel.deleteNote(note: editingRow)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.checkEmptiness()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
