//
//  PlaybackViewModel.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 23/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import AVFoundation

class PlaybackViewModel {
//    let urlPlay = BehaviorRelay<URL?>(value: URL(string: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4"))
    let urlPlay = BehaviorRelay<URL?>(value: Bundle.main.url(forResource: "big_buck_bunny_720p_30mb", withExtension: "mp4"))
    var asset: AVAsset!
    var player: AVPlayer!
    var playerItem: AVPlayerItem!

    let requiredAssetKeys = [
        "playable",
        "hasProtectedContent"
    ]

    func prepareToPlay(url: URL) {
        // Create the asset to play
        asset = AVAsset(url: url)

        // Create a new AVPlayerItem with the asset and an
        // array of asset keys to be automatically loaded
        playerItem = AVPlayerItem(asset: asset,
                                  automaticallyLoadedAssetKeys: requiredAssetKeys)

        // Associate the player item with the player
        player = AVPlayer(playerItem: playerItem)

        player.actionAtItemEnd = .pause
    }

}
