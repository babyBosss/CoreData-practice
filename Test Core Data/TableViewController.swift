//
//  TableViewController.swift
//  Test Core Data
//
//  Created by Alex on 18/06/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var toDoItems: [Task] = []
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Add task", message: "add new task", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default){ action in
            let textField = ac.textFields?[0]
            self.saveTask(taskToDo: (textField?.text)!)
            //self.toDoItems.insert((textField?.text)!, at: 0)
            self.tableView.reloadData()
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        ac.addTextField{
            textField in
        }
        
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    func saveTask(taskToDo: String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Task
        
        taskObject.taskToDo = taskToDo
        
        do{
            try context.save()
            toDoItems.append(taskObject)
            print("Saved!")
        } catch{
            print(error.localizedDescription)
        }
    }
    
    //get info from Core Data
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
   
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do{
            toDoItems = try context.fetch(fetchRequest)
        } catch{
            print(error.localizedDescription)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //cell.textLabel?.text = toDoItems[indexPath.row]
        let task = toDoItems[indexPath.row]
        cell.textLabel?.text = task.taskToDo
        
        return cell
    }
    

}
