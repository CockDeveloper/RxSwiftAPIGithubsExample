//
//  GHUsersAllTableViewCell.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 21/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import UIKit
import NetworkPlatform
import RxSwift
import RxCocoa

class GHUsersAllTableViewCell: UITableViewCell {

    let disposeBag = DisposeBag()
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

    func configData(user: GHUser) {
        logger.enter()
        textLabel?.rx.text.onNext(user.login)
        detailTextLabel?.rx.text.onNext(user.nodeId)

        Network<Data>()
            .requestGet(urlString: user.avatarUrl)
            .debug()
            .map({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .observeOn(MainScheduler.instance)
            .bind(to: (imageView?.rx.image)!)
            .disposed(by: disposeBag)

        logger.exit()
    }

}
