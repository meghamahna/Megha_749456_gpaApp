//
//  AddStudentViewController.swift
//  Megha_749456_gpaApp
//
//  Created by Megha Mahna on 2019-11-15.
//  Copyright © 2019 meghamahna. All rights reserved.
//

import UIKit

class AddStudentViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var studentId: UITextField!
    
    var studentDelegate: StudentsTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapgesture)
    }
    
    @objc func viewTapped(){
        
           firstName.resignFirstResponder()
           lastName.resignFirstResponder()
           studentId.resignFirstResponder()
    }
    

    @IBAction func save(_ sender: UIButton) {
        
        if firstName.text == nil || lastName.text == nil || studentId.text == nil{
            
            let alert = UIAlertController(title: "ALERT", message: "Empty Fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        else if firstName.text != nil && lastName.text != nil && studentId.text != nil{
        
        let alertController = UIAlertController(title: "Save", message: "Are you sure?", preferredStyle: .alert)
        let no = UIAlertAction(title: "No Way!", style: .cancel, handler: nil)
        no.setValue(UIColor.red, forKey: "titleTextColor")
        let yes = UIAlertAction(title: "Yes,I'm sure", style: .default) { (action) in
            
            let alertController1 = UIAlertController(title: "New Contact Saved", message: "\(self.firstName.text!) is now a student", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let first = self.firstName.text!
            let last = self.lastName.text!
            let sId = self.studentId.text!
            let student = Student(firstName: first, lastName: last, studentId: sId)
            print(student)
            Student.students.append(student)
            self.firstName.text = nil
            self.lastName.text = nil
            self.studentId.text = nil
            }
            
        alertController1.addAction(okAction)
        self.present(alertController1, animated: true, completion: nil)
        }
        alertController.addAction(no)
        alertController.addAction(yes)
        self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        studentDelegate?.tableView.reloadData()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
