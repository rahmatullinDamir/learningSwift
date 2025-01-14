//
//  ViewController.swift
//  Lesson3
//
//  Created by Damir Rakhmatullin on 13.01.25.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        return tableView
        
    }()
    
    var dataSource: [User] = Array(Array(repeating: User(name: "Damir", surname: "Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin", age: "20", image: UIImage(resource: .avatar)), count: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupLayout()
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier) as! CustomTableViewCell
        cell.configureCell(user: dataSource[indexPath.row])
        return cell
    }
    
    
}

