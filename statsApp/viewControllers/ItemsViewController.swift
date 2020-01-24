//
//  ItemsViewController.swift
//  statsApp
//
//  Created by Federico Lopez on 23/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var list: UITableView!
    var dataProvider: [Item] = []
    var itemForSegueManageItem: Item? = nil
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Items"
        
        self.list.tableFooterView = UIView()
        let nib = UINib.init(nibName: "ItemCell", bundle: nil)
        self.list.register(nib, forCellReuseIdentifier: "ItemCell")
        self.list.delegate = self
        self.list.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Item.getAll { (items) in
            if let _items = items {
                self.dataProvider = _items
                self.list.reloadData()
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.setData(self.dataProvider[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            self.itemForSegueManageItem = self.dataProvider[indexPath.row]
            self.performSegue(withIdentifier: "gotoManageItem", sender: self)
        }
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            print("DELETE!")
        }
        
        return [editAction, deleteAction]
    }
    
    // MARK: Actions
    @IBAction func addButtonTap(_ sender: Any) {
        self.itemForSegueManageItem = nil
        self.performSegue(withIdentifier: "gotoManageItem", sender: self)
    }
    
    // MARK: misc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "gotoManageItem") {
            let vc = segue.destination as! ManageItemViewController
            vc.item = itemForSegueManageItem
        }
    }
    
    
}
