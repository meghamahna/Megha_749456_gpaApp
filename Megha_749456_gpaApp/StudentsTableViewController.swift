//
//  StudentsTableViewController.swift
//  Megha_749456_gpaApp
//
//  Created by Megha Mahna on 2019-11-15.
//  Copyright © 2019 meghamahna. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var search: UISearchBar!
    
    var data : [Student]!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        search.delegate = self
        data = Student.students
            
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "student")
            cell?.textLabel?.text = "\(data[indexPath.row].firstName)" + " " + "\(data[indexPath.row].lastName)"

        // Configure the cell...
            return cell!
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        data = searchText.isEmpty ? Student.students : Student.students.filter{ (item: Student) -> Bool in
                    let name = item.firstName + " " + item.lastName
                    return name.lowercased().contains(searchText.lowercased())
                }
                tableView.reloadData()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let detailView = segue.destination as? AddStudentViewController
        {
            detailView.studentDelegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        data = Student.students
        tableView.reloadData()
    }
    

}
