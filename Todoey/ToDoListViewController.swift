//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
var itemArr = [Stuff]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
           
        
    override func viewDidLoad() {
        super.viewDidLoad()
//if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
  //          itemArr = items
        
    //    }
        
       loadItems()
    }




//MARK: - UITableViewControllerDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        cell.textLabel?.text = itemArr[indexPath.row].task_name
        
        cell.accessoryType = itemArr[indexPath.row].Status ? .checkmark : .none
        if itemArr[indexPath.row].Status == false{
            cell.accessoryType = .none
        }
        else{
            cell.accessoryType = .checkmark
        }
        return cell
    
    
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArr[indexPath.row].Status = !itemArr[indexPath.row].Status
           saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addbuttonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new ToDoey item", message: "", preferredStyle: .alert)
        let action  = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let x = Stuff()
            x.task_name = textField.text!
            if x.task_name != ""{
                self.itemArr.append(x)
                self.saveItems()
                
            
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated:true,completion: nil)
    
    }
    


func saveItems(){
    let encoder = PropertyListEncoder()
        do {
            let Data = try encoder.encode(itemArr)
            try Data.write(to: dataFilePath!)
        } catch  {
        print("error while encoding")
        }
        
        tableView.reloadData()
        }
    
    
    
    func loadItems(){
        if let data = try?Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArr = try decoder.decode([Stuff].self, from: data)
                
            }catch{
                print("\(error)")
            }
        }
    }
}
