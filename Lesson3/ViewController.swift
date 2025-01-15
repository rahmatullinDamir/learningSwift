//
//  ViewController.swift
//  Lesson3
//
//  Created by Damir Rakhmatullin on 13.01.25.
//

import UIKit

class ViewController: UIViewController {
    enum TableSections {
        case main
        case secondary
    }
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        return tableView
        
    }()
    
    var dataSource: UITableViewDiffableDataSource<TableSections, User>?
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        for _ in 0 ..< 5 {
            users.append(User(name: "Damir", surname: "Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin", age: "\(Int.random(in: 0 ..< 100))", image: UIImage(resource: .avatar)))
        }
        
        setupLayout()
        setupDataSource()
        setupNavigationBar()
    }
    
    
    func setupNavigationBar() {
        let editAction = UIAction { UIAction in
            self.tableView.isEditing.toggle()
        }
        
        let addAction = UIAction { UIAction in
            guard var snapashot = self.dataSource?.snapshot() else {return}
            snapashot.appendItems([User(name: "Ivan", surname: "Urgant!", age: "\(Int.random(in: 0..<100))", image: UIImage(resource: .avatar))], toSection: .secondary)
            self.dataSource?.apply(snapashot, animatingDifferences: true)
        }
        navigationItem.title = "Main"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editAction)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)
        
    }
    func setupDataSource () {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier) as! CustomTableViewCell
            cell.configureCell(user: itemIdentifier)
            return cell
        })
        updateSnapshotWithUsers(users: users, animate: false)
    }
    
    func updateSnapshotWithUsers(users: [User], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSections, User>()
        snapshot.appendSections([.main, .secondary])
        snapshot.appendItems(users)
        dataSource?.apply(snapshot, animatingDifferences: animate)
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
extension ViewController: UITableViewDelegate {

    
}

