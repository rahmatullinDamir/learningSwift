//
//  DetailViewController.swift
//  Lesson3
//
//  Created by Damir Rakhmatullin on 30.01.25.
//



import UIKit

protocol EditUserDataDelegate: AnyObject {
    func editUserData(user: User);
}

class DetailViewController: UIViewController {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    weak var editUserDataDelegate: EditUserDataDelegate?
    
    var currentUser: User?
    
    lazy var button: UIButton = {
        
        let action = UIAction { UIAction in
            self.editUserDataDelegate?.editUserData(user: self.currentUser!);
            self.navigationController?.popViewController(animated: true)
        }
        
        let button = UIButton(type: .system, primaryAction: action)
        button.setTitle("Tap me", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
          
        ])
        
        
    }
    
    init(with user: User) {
        super.init(nibName: nil, bundle: nil)
        currentUser = user
        label.text = user.name + " "  + user.surname
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
