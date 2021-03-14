//
//  ResultViewController.swift
//  Form_App
//
//  Created by webwerks1 on 05/02/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

protocol ResultViewControllerDelegate : class {
    
    func recordDeletedAtIndexPath(indexpath : IndexPath)
    func recordEditedAtIndexPath(row : Int)
}

class ResultViewController: UIViewController {
    
    weak  var  delegate : ResultViewControllerDelegate?
    var data = [Form]()
    var FdataText : UITextField?
    var indexOfRowOfEditButton :Int?
    
    @IBOutlet weak var backToFormButton: UIButton!

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        
    }
    
    
    @IBAction func formButtonPressed(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }

}

// UITabelViewDelgate
extension ResultViewController : UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// UITableDatasource
extension ResultViewController : UITableViewDataSource {
    //function for rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    //function for row's cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as!TableViewCell
        
        customCell.deleteCellOutlet.tag = indexPath.row //providing tag to buttons
        customCell.editCellOutlet.tag = indexPath.row   // providing tag to buttons
        
        //delete button when pressed inside the custom cell
        customCell.deleteCellOutlet.addTarget(self, action: #selector(deleteActionPerformed(button:)), for: .touchUpInside)
        //edit button when pressed inside custom cell
        customCell.editCellOutlet.addTarget(self, action: #selector(editActionPerformed(button:)), for: .touchUpInside)
        //chaniging label.text of custom cell by calling function
        customCell.configure(details: "Name: \(data[indexPath.row].name)\n"+" Surname: \(data[indexPath.row].surname)\n Gender: \(data[indexPath.row].gender)\n Education Staus: \(data[indexPath.row].educationStatus)\n Phone: \(data[indexPath.row].phoneNo)\n EmailId: \(data[indexPath.row].emailId)\n")
        
        
        return customCell
        
        
    }
    // function to delete cell
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    // function to delete cell function by providing animation
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            data.remove(at: indexPath.row)
            delegate?.recordDeletedAtIndexPath(indexpath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
        
        
    }
    // function when delete button is pressed in custom cell
    @objc func deleteActionPerformed(button : UIButton)  {
        print(button.tag)
        let indexPath = IndexPath(row: button.tag, section: 0)
        
        data.remove(at: button.tag)
        delegate?.recordDeletedAtIndexPath(indexpath: indexPath)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
        
    }
    // function when edit button is pressed in cutom cell
    
    @objc func editActionPerformed(button : UIButton) {
        
        delegate?.recordEditedAtIndexPath(row : button.tag)
        
        //self.performSegue(withIdentifier:"goToForm" , sender: self)
        self.dismiss(animated: true, completion: nil)
        // self.navigationController?.popViewController(animated: true)
        
        
    }
    //function to execute command before segue happens
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToForm"{
            let formViewController = segue.destination as! ViewController

            
        }
    }
}

