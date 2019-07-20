//
//  MainViewModel.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 20/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class MainViewModel {
    enum Action {
        case none
        case gotoGithub
    }

    let action = BehaviorRelay<Action>(value: .none)

    func tapAPIGitHubButton() {
        logger.enter()

        action.accept(.gotoGithub)

        logger.exit()
    }
}
