//
//  NoteTableViewCell.swift
//  myNotes
//
//  Created by Полищук Александр on 11.01.2023.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.text = "This is text note"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with note: Notes) {
        titleLabel.text = note.title
        noteLabel.text = note.note
    }
}

private extension NoteTableViewCell {
    func setupViews() {
        layer.cornerRadius = 5
        accessoryType = .disclosureIndicator
        layer.cornerRadius = 10
        addSubview(verticalStack)
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(noteLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
