//
//  TableViewCell.swift
//  Form_App
//
//  Created by webwerks1 on 09/02/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import UIKit

/*protocol TableViewCellDelegate : class {
 func deleteCustomCellWithBtn(button : UIButton)
 }*/

class TableViewCell: UITableViewCell {
    
    
    static let identifier = "TableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
    //weak var  deleteDelegate : TableViewCellDelegate?
    
    public func configure (details : String ){
        cellDetailsLabel.numberOfLines = 0
        cellDetailsLabel.lineBreakMode = .byWordWrapping
        cellDetailsLabel.text = details
        
    }
    
    @IBOutlet weak var cellDetailsLabel: UILabel!
    @IBOutlet weak var editCellOutlet: UIButton!
    @IBOutlet weak var deleteCellOutlet: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
