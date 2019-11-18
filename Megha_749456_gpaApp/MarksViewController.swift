//
//  MarksViewController.swift
//  Megha_749456_gpaApp
//
//  Created by Megha Mahna on 2019-11-16.
//  Copyright © 2019 meghamahna. All rights reserved.
//

import UIKit
import AVFoundation
class MarksViewController: UIViewController {
    
    
    var semesterDelegate: SemesterTableViewController?
    //var currentIndex = -1
    var gpa = 0.0
    var gpaSum = 0.0
    var creditHoursSum = 0.0
    var audioPlayer: AVAudioPlayer!
    let sounds = ["Win"]
    
    @IBOutlet weak var course1Label: UILabel!
    @IBOutlet weak var course2Label: UILabel!
    @IBOutlet weak var course3Label: UILabel!
    @IBOutlet weak var course4Label: UILabel!
    @IBOutlet weak var course5Label: UILabel!
    
    @IBOutlet weak var course1Textfield: UITextField!
    @IBOutlet weak var course2Textfield: UITextField!
    @IBOutlet weak var course3Textfield: UITextField!
    @IBOutlet weak var course4Textfield: UITextField!
    @IBOutlet weak var course5Textfield: UITextField!
    
    @IBOutlet weak var gpaLabel: UILabel!
    
    var creditHours = [Double]()
    var subjectWiseGPA = [Double]()
    
    override func viewDidLoad() {
        
            Grade.grades = []
           super.viewDidLoad()
           let tapgesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
           self.view.addGestureRecognizer(tapgesture)
           // Do any additional setup after loading the view.
       }
    
    @objc func viewTapped(){
        
          course1Textfield.resignFirstResponder()
          course2Textfield.resignFirstResponder()
          course3Textfield.resignFirstResponder()
          course4Textfield.resignFirstResponder()
          course5Textfield.resignFirstResponder()
        
       }
    
    func calculateGPA(marks: Double) -> Double{
        
        switch(marks){
            
            case 0..<50:
                    return   0.0
            
            case 50...59:
                    return  1.0
            
            case 60...62:
                    return   1.7
            
            case 63...66:
                    return  2.0
            
            case 67...69:
                    return   2.3
            
            case 70...76:
                    return   3.0
            
            case 77...79:
                    return   3.2
            
            case 80...86:
                    return  3.5
            
            case 87...93:
                    return  3.7
            
            case 94...100:
                    return  4.0
            
            default:
                break
        }
        return 0.0
    }
    
    func calculateCreditHours(){
        
        creditHours.append((Double(String(course1Label.text!.last!))!))
        creditHours.append((Double(String(course2Label.text!.last!))!))
        creditHours.append((Double(String(course3Label.text!.last!))!))
        creditHours.append((Double(String(course4Label.text!.last!))!))
        creditHours.append((Double(String(course2Label.text!.last!))!))
    }

    func calculateSubjectWiseGPA(){
        
        subjectWiseGPA.append(calculateGPA(marks: Double(course1Textfield.text!)!))
        subjectWiseGPA.append(calculateGPA(marks: Double(course2Textfield.text!)!))
        subjectWiseGPA.append(calculateGPA(marks: Double(course3Textfield.text!)!))
        subjectWiseGPA.append(calculateGPA(marks: Double(course4Textfield.text!)!))
        subjectWiseGPA.append(calculateGPA(marks: Double(course5Textfield.text!)!))
        
    }
   
    
    @IBAction func calculate(_ sender: UIButton) {
        
        if course1Textfield.text == nil || course2Textfield.text == nil || course3Textfield.text == nil || course4Textfield.text == nil || course5Textfield.text ==  nil {
        let alertController = UIAlertController(title: "GPA calculation ", message: "You have empty textfield", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion:  nil)
        
        }
        
        else if course1Textfield.text != nil || course2Textfield.text != nil || course3Textfield.text != nil || course4Textfield.text == nil || course5Textfield.text !=  nil {
            calculateCreditHours()
            calculateSubjectWiseGPA()
            for i in 0...4{
            
                creditHoursSum = creditHoursSum + creditHours[i]
                gpaSum = gpaSum + (creditHours[i] * subjectWiseGPA[i])
            }
        
            let result = gpaSum / creditHoursSum
            gpaLabel.text =  String(format: "%.1f",result) + "/4"
            let grade1 = Grade(grade: gpaLabel.text!)
            Grade.grades.append(grade1)
            print(semesterDelegate?.currentIndex)
            //Grade.grades.insert(grade1, at: (semesterDelegate?.currentIndex)!)
            //Grade.grades.insert(grade1, at: (semesterDelegate?.currentIndex)!)
           // Grade.grades[(semesterDelegate?.currentIndex)!] = grade1
            // semesterDelegate?.gpaCalculate(text: gpaLabel.text!)
            if result >= 2.8{
                let select = sounds[sender.tag]
                let soundURL = Bundle.main.url(forResource: select, withExtension: "wav")
                audioPlayer = try! AVAudioPlayer(contentsOf: soundURL!)
                audioPlayer.play()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        course1Label.text = Semester.semesters[(semesterDelegate?.currentIndex)!].courseName[0]
        course2Label.text = Semester.semesters[(semesterDelegate?.currentIndex)!].courseName[1]
        course3Label.text = Semester.semesters[(semesterDelegate?.currentIndex)!].courseName[2]
        course4Label.text = Semester.semesters[(semesterDelegate?.currentIndex)!].courseName[3]
        course5Label.text = Semester.semesters[(semesterDelegate?.currentIndex)!].courseName[4]
       
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
