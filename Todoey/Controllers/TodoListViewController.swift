//
//  ViewController.swift
//  Todoey
//
//  Created by Ying Zhou on 1/13/19.
//  Copyright © 2019 3cslab.com. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {


    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category?{
        didSet{
           loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    // mark - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row]{
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        } else {
                cell.textLabel?.text = "No items added"
                }
        
        return cell
    }
//MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
//        context.delete(todoItems[indexPath.row])
//        todoItems.remove(at: indexPath.row)
    
 //       todoItems?[indexPath.row].done = !todoItems?[indexPath.row].done ?? false
   
//        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message:"", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let currentCategory = self.selectedCategory {
                do {
                try self.realm.write {
                     let newItem = Item()
                     newItem.title = textField.text!
                    currentCategory.items.append(newItem)
                }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
//    func saveItems() {
//
//
//        do {
//            try context.save()
//
//        } catch {
//           print("Error saving context \(error)")
//
//        }
//        self.tableView.reloadData()
//    }
    
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}

//Mark: Search Bar Patterns

//extension TodoListViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        
//       request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        // [cd] means not case sensitive or diacretic sensitive
//
//       request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request)
//    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//            DispatchQueue.main.async {
//                 searchBar.resignFirstResponder()
//            }
//
//        }
//    }
//}
