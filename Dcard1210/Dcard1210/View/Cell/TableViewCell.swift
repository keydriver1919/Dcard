//
//  TableViewCell.swift
//  Dcard1210
//
//  Created by change on 2021/12/10.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var titleType: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var recallLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
