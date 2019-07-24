//
//  AVPlayer+Rx.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 23/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import Foundation
import AVFoundation
import RxSwift

extension Reactive where Base: AVPlayer {
    var timeControlStatus: Observable<AVPlayer.TimeControlStatus> {
        return observe(AVPlayer.TimeControlStatus.self, #keyPath(AVPlayer.timeControlStatus))
            .map { $0 ?? .waitingToPlayAtSpecifiedRate }
    }
}
