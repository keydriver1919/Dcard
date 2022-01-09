//
//  DetailTableViewCell.swift
//  Dcard1210
//
//  Created by change on 2021/12/10.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var detailUserImage: UIImageView!
    @IBOutlet weak var detailType: UILabel!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var detailArticle: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
