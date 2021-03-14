//
//  ViewController.swift
//  Form_App
//
//  Created by webwerks1 on 03/02/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var maleBtn: UIButton!
    
    @IBOutlet weak var femaleBtn: UIButton!
    
    @IBOutlet weak var submitOutletBtn: UIButton!
    
    @IBOutlet weak var educationLabel: UILabel!
    
    @IBOutlet weak var validatingLabel: UILabel!
    
    @IBOutlet weak var PhoneTextField: UITextField!
    
    var timer = Timer()
    var formData = [Form]()
    var genderValue = ""
    var recordToEdit : Form?
    
    
    // var flag2 : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        surnameTextField.delegate = self
        PhoneTextField.delegate = self
        emailTextField.delegate = self
        
        
        
    }
    
    // Radio button when checked either Male or Female
    @IBAction func radioBtnChecked(_ sender: UIButton) {
        if sender.tag == 1 // on interface builder in veiw mode there is tag option ehic is selected as 1
        {
            maleBtn.isSelected = true
            femaleBtn.isSelected = false
            genderValue = "Male"
            //print("male slected")
        }
        else if sender.tag == 2
        {
            
            femaleBtn.isSelected = true
            maleBtn.isSelected = false
            genderValue = "Female"
            //print("female selected")
        }
    }
    
    // function for UI Slider.......................................
    @IBAction func educatonSlider(_ sender: UISlider) {
        let val = Int(sender.value)
        switch val {
        case 1: educationLabel.text = "Below ssc"
        case 2 : educationLabel.text = "Ssc"
        case 3 : educationLabel.text = "Hsc"
        case 4 : educationLabel.text = "B.E"
        case 5 : educationLabel.text = "M.E"
        case 6 : educationLabel.text = "Phd"
        default: educationLabel.text = "Below Ssc"
        }
    }
    
    // Submit button code...............................
    @IBAction func submitButton(_ sender: UIButton)
    {
        
        timer.invalidate() // incase of multiple button tapped
        submitOutletBtn.backgroundColor = UIColor.cyan
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
        
        validateData()
    }
    @objc func timerAction()
    {
        
        submitOutletBtn.backgroundColor = UIColor.clear
        
    }
    
    
}

// these is delegate to return on screen after keybord types returns key or touch on screen
extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // function for TextFiled goes whenever touch occur in screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
        PhoneTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
}
// extension to remove data from formdata
extension ViewController : ResultViewControllerDelegate {
    
    func recordEditedAtIndexPath(row: Int) {
        let formdetails = formData[row]
        print("in record edit delegate")
        nameTextField.text = formdetails.name
        surnameTextField.text = formdetails.surname
        PhoneTextField.text = String(formdetails.phoneNo)
        emailTextField.text = formdetails.emailId
        self.recordToEdit = formdetails
        
        
    }
    
    
    
    func recordDeletedAtIndexPath(indexpath: IndexPath) {
        self.formData.remove(at: indexpath.row)
    }
    
    
}
// autopopulating extension
extension ViewController{
    func autoPopulate(formdetails : Form)
    {
        
        
        
    }
}
// extension for validation and segue performation
extension ViewController{
    func validateData()
    {
        if(nameTextField.text == "")
        {
            nameTextField.placeholder = "please enter your name"
            nameTextField.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        }
        else if(surnameTextField.text == "")
        {
            surnameTextField.placeholder = "please enter your surname"
            surnameTextField.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        }
        else if(genderValue == "" )
        {
            validatingLabel.text = "please check the male or female"
        }
        else if(PhoneTextField.text == "")
        {
            PhoneTextField.placeholder = " plese enter the phone number"
            PhoneTextField.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        }
        else if(emailTextField.text == "")
        {
            emailTextField.placeholder = "please enter the email id"
            emailTextField.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        }
        else{
            
            validatingLabel.text = ""
            if var editRecord = self.recordToEdit,let firstIndex = formData.firstIndex(where: {$0.uid==editRecord.uid })
            {
                print("i am in record edit field")
                editRecord.name = nameTextField.text!
                editRecord.surname = surnameTextField.text!
                editRecord.gender = genderValue
                editRecord.educationStatus = educationLabel.text!
                editRecord.phoneNo = Int(PhoneTextField.text!)!
                editRecord.emailId = emailTextField.text!
                
                formData[firstIndex] = editRecord
                
                
            }
            else{
                 print("i am in record  field")
                var formdataforcell = Form(name: nameTextField.text!, surname: surnameTextField.text!, gender: genderValue, educationStatus: educationLabel.text!, phoneNo: Int(PhoneTextField.text!)!, emailId: emailTextField.text!)
                
                formdataforcell.uid = "\(Date().timeIntervalSinceNow)"
                
                formData.append(formdataforcell)
            }
            
            //formData[counter].formDetails()
            
            self.performSegue(withIdentifier: "goToResult", sender: self)
            
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            
            let destinationVC = segue.destination as! ResultViewController
            
            destinationVC.data = formData
            
            destinationVC.delegate = self
            
        }
    }
}


