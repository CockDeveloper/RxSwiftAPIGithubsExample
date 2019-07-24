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
        case gotoPlayback
    }

    let action = BehaviorRelay<Action>(value: .none)
    let items = BehaviorRelay<[GHUser]>(value: [GHUser]())
    let observableNext = BehaviorRelay<Int>(value: 0)//= Observable<Int>.of(1)
    private let disposeBag = DisposeBag()
    private let numberOfItemsEach: Int = 3

    func getAllUsers(urlString: String = "https://api.github.com/users") {
        logger.enter()

        Observable<[GHUser]>.create { [unowned self] observer -> Disposable in
            if self.observableNext.value < 3 {
                Network<[GHUser]>()
                    .requestGetJSON(urlString: urlString)
                    .subscribe(onNext: { [unowned self] listUsers in
                        if listUsers.count < self.numberOfItemsEach {
                            observer.onNext(listUsers)
                        } else {
                            var randUsers = [GHUser]()
                            repeat {
                                let index = Int(arc4random())%listUsers.count
                                randUsers.append(listUsers[index])
                            } while (randUsers.count < self.numberOfItemsEach)

                            observer.onNext(randUsers)
                        }
                    },
                               onError: { logger.error($0) },
                               onCompleted: { //[unowned self] in
                                //                                self.observableNext
                                //                                    .delay( .seconds(10), scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
                                //                                    .takeLast(1)
                                //                                    .subscribe(onNext: { [unowned self] numRepeat in
                                //                                        self.getAllUsersNext()
                                //                                        self.observableNext.accept(numRepeat + 1)
                                //                                    })
                                //                                    .disposed(by: self.disposeBag)

                    })
                    .disposed(by: self.disposeBag)
            }
            return Disposables.create()
            }
            .observeOn(ConcurrentMainScheduler.instance)
            .bind(to: items)
            .disposed(by: disposeBag)

        logger.exit()
    }

    func getAllUsersNext() {
        getAllUsers(urlString: "https://api.github.com/users?since=\(String(describing: items.value.last?.id))")
    }

    func tapBackButton() {
        logger.enter()

        action.accept(.gotoMain)

        logger.exit()
    }

    func tapCell(at index: IndexPath) {
        logger.enter()

        action.accept(.gotoPlayback)

        logger.exit()
    }
}
