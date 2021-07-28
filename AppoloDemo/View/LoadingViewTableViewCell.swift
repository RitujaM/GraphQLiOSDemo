//
//  LoadingViewTableViewCell.swift
//  AppoloDemo
//
//  Created by Rituja Mahajan on 7/27/21.
//

import UIKit

class LoadingViewTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
