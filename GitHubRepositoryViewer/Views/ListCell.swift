//
//  ListCell.swift
//  GitHubRepositoryViewer
//
//  Created by AtsuyaSato on 2017/04/05.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit
import PINRemoteImage
class ListCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(repo: Repository) {
        fullNameLabel.text = repo.fullName
        avatarImageView.pin_setImage(from: URL(string: repo.ownerAvaterUrl!), completion: nil)
        updatedAtLabel.text = repo.updatedAt
        urlLabel.text = repo.url
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
