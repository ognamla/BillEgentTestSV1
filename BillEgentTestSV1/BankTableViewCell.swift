//
//  BankTableViewCell.swift
//  BillEgentTestSV1
//
//  Created by kuan-yu Chiang on 08/06/2017.
//  Copyright © 2017 kuan-yu Chiang. All rights reserved.
//

import UIKit

class BankTableViewCell: UITableViewCell {
    
    @IBOutlet var bankLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var moneyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
