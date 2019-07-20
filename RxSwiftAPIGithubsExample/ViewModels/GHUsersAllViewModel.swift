//
//  GHUsersAllViewModel.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 20/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import NetworkPlatform

class GHUsersAllViewModel {
    enum Action {
        case none
        case gotoMain
    }

    let action = BehaviorRelay<Action>(value: .none)
    let items = BehaviorRelay<[GHUser]>(value: [GHUser]())
    private let disposeBag = DisposeBag()

    func getAllUsers() {
        logger.enter()
        Network<[GHUser]>()
            .requestGetJSON(urlString: "https://api.github.com/users")
            .bind(to: items)
            .disposed(by: disposeBag)
        logger.exit()
    }

    func tapBackButton() {
        logger.enter()

        action.accept(.gotoMain)

        logger.exit()
    }
}
