//
//  RepoListTableViewCell.swift
//  AppoloDemo
//
//  Created by Rituja Mahajan on 7/26/21.
//

import UIKit

class RepoListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRepoName: UILabel!
    @IBOutlet weak var lblLoginName: UILabel!
    @IBOutlet weak var lblStars: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCellData(){
        
    }

}
