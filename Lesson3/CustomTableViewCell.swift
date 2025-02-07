//
//  CustomTableViewCell.swift
//  Lesson3
//
//  Created by Damir Rakhmatullin on 14.01.25.
//

import UIKit

protocol showAlert: AnyObject {
    func showAlert(title: String, message: String)
}

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
        mainStackView.alignment = .leading
        mainStackView.distribution = .fill
        return mainStackView
    }()
    
    weak var delegate: showAlert?
    
    lazy var alertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.actions, for: .normal)
        var alertAction = UIAction(handler: { UIAction in
            self.delegate?.showAlert(title: "Poshel nahyi", message: "\(self.username!)")
        })
        
        button.addAction(alertAction, for: .touchUpInside)
        
        return button
    }()
    
    var username: String?
    
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
        username = user.name
    }
    
    func setupLayout() {
        guard image.superview == nil else { return }
        contentView.addSubview(mainStackView)
        contentView.addSubview(image)
        contentView.addSubview(ageTitle)
        contentView.addSubview(alertButton)
        
        mainStackView.addArrangedSubview(title)
        mainStackView.addArrangedSubview(subtitle)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50),
           
            ageTitle.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            ageTitle.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            ageTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            alertButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 24),
            alertButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            mainStackView.leadingAnchor.constraint(equalTo: image.trailingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: ageTitle.leadingAnchor, constant: -16),
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
