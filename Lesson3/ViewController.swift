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
            users.append(User(id: UUID(), name: "Damir", surname: "Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin, Rahmatullin", age: "\(Int.random(in: 0 ..< 100))", image: UIImage(resource: .avatar)))
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
            if var snapshot = self.dataSource?.snapshot() {
                let user = User(id: UUID(), name: "Ivan", surname: "Urgant!", age: "\(Int.random(in: 0..<100))", image: UIImage(resource: .avatar))
                snapshot.appendItems([user], toSection: .secondary)
                self.users.append(user)
                self.dataSource?.apply(snapshot)
            }

        }
        navigationItem.title = "Main"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editAction)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)
        
    }
    func setupDataSource () {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier) as! CustomTableViewCell
            cell.configureCell(user: itemIdentifier)
            cell.delegate = self
            cell.showAnotherAlert = { [weak self] in
                let alert = UIAlertController(title: "HYI", message: "closure alert!", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(okAction)
                self?.navigationController?.topViewController?.present(alert, animated: true)
            }
            return cell
        })
        tableView.dataSource = dataSource
  
        dataSource?.defaultRowAnimation = .automatic
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
    

}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = dataSource?.itemIdentifier(for: indexPath) {
            let detailView = DetailViewController(with: user)
            detailView.editUserDataDelegate = self
            navigationController?.pushViewController(detailView, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}


extension ViewController: showAlert {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        self.navigationController?.topViewController?.present(alert, animated: true)
    }
}

extension ViewController: EditUserDataDelegate {
    func editUserData(user: User) {
        guard let userIndex = dataSource?.indexPath(for: user)?.row else { return }
        users.remove(at: userIndex)
        users.insert(User(id: user.id, name: "Some name", surname: "Some username", age: "\(Int.random(in: 0..<100))", image: .avatar), at: userIndex)
        setupDataSource()
    }
}
