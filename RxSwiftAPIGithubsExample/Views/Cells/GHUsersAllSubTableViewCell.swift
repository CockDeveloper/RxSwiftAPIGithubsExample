//
//  GHUsersAllSubTableViewCell.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 22/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import UIKit

class GHUsersAllSubTableViewCell: GHUsersAllTableViewCell {

    override func awakeFromNib() {
        logger.enter()
        super.awakeFromNib()
        // Initialization code
        logger.exit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        logger.enter()
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        logger.exit()
    }

}
