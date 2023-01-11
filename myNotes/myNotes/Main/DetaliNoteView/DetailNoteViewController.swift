//
//  DetailNoteViewController.swift
//  myNotes
//
//  Created by Полищук Александр on 11.01.2023.
//

import UIKit

class DetailNoteViewController: UIViewController {
    
    private var viewModel: DetailNoteViewModel!
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var noteTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Note Text"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter title"
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 20, weight: .semibold)
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.25
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.rightView = paddingView
        textField.rightViewMode = .always
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var noteTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18, weight: .regular)
        textView.textColor = .black
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 0.25
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    init(viewModel: DetailNoteViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    func configureChosenNote(with note: Notes) {
        viewModel.isEditing = true
        viewModel.currentNote = note
        title = "Edit mode"
        titleTextField.text = note.title
        noteTextView.text = note.note
    }
    
    @objc private func saveButtonTapped() {
        if titleTextField.text!.isEmpty || noteTextView.text.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "All fields required", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        } else {
            guard let title = titleTextField.text else { return }
            guard let note = noteTextView.text else { return }
            viewModel.saveNote(with: title, note: note)
            viewModel.router.popToRoot()
        }
    }
}

private extension DetailNoteViewController {
    
    func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(noteTextLabel)
        view.addSubview(noteTextView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            noteTextLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5),
            noteTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            noteTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            noteTextView.topAnchor.constraint(equalTo: noteTextLabel.bottomAnchor, constant: 5),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            noteTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -320),
        ])
    }
}
