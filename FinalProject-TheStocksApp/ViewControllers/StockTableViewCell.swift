//
//  StockTableViewCell.swift
//  FinalProject-TheStocksApp
//
//  Created by Jesus Alvarado on 5/24/22.
//

import UIKit

class StockTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var openPrice: UILabel!
    
    @IBOutlet weak var closePrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
