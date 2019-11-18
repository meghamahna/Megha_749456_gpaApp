//
//  SemesterTableViewController.swift
//  Megha_749456_gpaApp
//
//  Created by Megha Mahna on 2019-11-16.
//  Copyright © 2019 meghamahna. All rights reserved.
//

import UIKit

class SemesterTableViewController: UITableViewController {

    var gpa = ""
    var currentIndex = -1
    var semDelegate: StudentsTableViewController?
    var sum = 0.0
    var totalGpa: Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        let sem1 = Semester(semesterName: "Semester 1", courseName: ["MAD 3004","MAD 3115", "MAD 2303", "MAD 3463", "MAD 3125"])
        let sem2 = Semester(semesterName: "Semester 2", courseName: ["MAD 3005","MAD 3115", "MAD 2303", "MAD 3463", "MAD 3125"])
        let sem3 = Semester(semesterName: "Semester 3", courseName: ["MAD 3006","MAD 3115", "MAD 2303", "MAD 3463", "MAD 3125"])
        

        Semester.semesters = [sem1, sem2, sem3]
        Grade.grades = []
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
        return Semester.semesters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sem")
        cell?.textLabel?.text = Semester.semesters[indexPath.row].semesterName
        //cell?.detailTextLabel?.text = Grade.grades[indexPath.row].grade
        if let label = cell!.viewWithTag(1) as? UILabel{
            if indexPath.row < Grade.grades.count{
            
               // label.text = Grade.grades[indexPath.row].grade
               
            }
        }
        if indexPath.row < Grade.grades.count{
         cell?.detailTextLabel?.text = Grade.grades[indexPath.row].grade
        }
        return cell!
    }
    
    func total(){
        
        if Grade.grades != nil{
            sum = sum + Double(Grade.grades[0].grade)! + Double(Grade.grades[1].grade)! + Double(Grade.grades[2].grade)!
            
                
            }
            totalGpa = sum / 3
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
        
        if let detailView = segue.destination as? MarksViewController{
            detailView.semesterDelegate = self
            if let tableViewCell = sender as? UITableViewCell{
                if let index = tableView.indexPath(for: tableViewCell)?.row{
                    currentIndex = index
                }
            }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        semDelegate?.tableView.reloadData()
        tableView.reloadData()
    }
            
}
