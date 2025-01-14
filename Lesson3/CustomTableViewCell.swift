//
//  CustomTableViewCell.swift
//  Lesson3
//
//  Created by Damir Rakhmatullin on 14.01.25.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    lazy var title: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subtitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        return label
    }()
    lazy var ageTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var image: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var mainStackView: UIStackView = {
        var mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.alignment = .fill
        return mainStackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    override func prepareForReuse() {
        image.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(user: User) {
        title.text = user.name
        subtitle.text = user.surname
        ageTitle.text = user.age
        image.image = user.image
    }
    func setupLayout() {
        guard image.superview == nil else { return }
        contentView.addSubview(mainStackView)
        contentView.addSubview(image)
        contentView.addSubview(ageTitle)
        mainStackView.addArrangedSubview(title)
        mainStackView.addArrangedSubview(subtitle)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            image.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
//            image.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50),
           
            ageTitle.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            ageTitle.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            ageTitle.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
//            ageTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: image.trailingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: ageTitle.leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
}
extension CustomTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
