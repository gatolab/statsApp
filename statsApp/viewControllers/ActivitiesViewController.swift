//
//  ItemsViewController.swift
//  statsApp
//
//  Created by Federico Lopez on 23/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var list: UITableView!
    
    var firstTime = true
    var dataProvider: [Activity] = []
    var itemForSegueManageItem: Activity? = nil
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Activities"
        
        self.list.tableFooterView = UIView()
        let nib = UINib.init(nibName: "ActivityCell", bundle: nil)
        self.list.register(nib, forCellReuseIdentifier: "ActivityCell")
        self.list.delegate = self
        self.list.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateActivities),
                                               name: nUpdateActivities, object: nil)
    }
    @objc func updateActivities(notification: Notification) {
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(self.firstTime) {
            loadData()
        }
    }
    
    func loadData() {
        Activity.getAll { (items) in
            if let _items = items {
                self.dataProvider = _items
                self.list.reloadData()
            }
            self.firstTime = false
        }
    }
    
    // MARK: - UITableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataProvider.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        cell.setData(self.dataProvider[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (cAction, view, isComplete) in
            self.itemForSegueManageItem = self.dataProvider[indexPath.row]
            self.performSegue(withIdentifier: "gotoManageActivity", sender: self)
            isComplete(true)
        }
        editAction.backgroundColor = UIColor(hex: 0xC09642, alpha: 1.0)
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (cAction, view, isComplete) in
            ALERT(text: "Delete selected activity?", viewController: self) { (result) in
                isComplete(true)
                if(result) {
                    let item = self.dataProvider[indexPath.row]
                    item.delete { (error) in
                        if(error == nil) {
                            isComplete(true)
                            self.loadData()
                        }
                    }
                }
            }
        }
        
        let actions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return actions
    }
    
    // MARK: Actions
    @IBAction func addButtonTap(_ sender: Any) {
        self.itemForSegueManageItem = nil
        self.performSegue(withIdentifier: "gotoManageActivity", sender: self)
    }
    
    // MARK: misc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "gotoManageActivity") {
            let vc = segue.destination as! ManageActivityViewController
            vc.activity = itemForSegueManageItem
        }
    }
    
    
}
