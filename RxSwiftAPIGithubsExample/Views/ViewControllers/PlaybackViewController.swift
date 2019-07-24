//
//  PlaybackViewController.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 23/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

class PlaybackViewController: UIViewController {

    @IBOutlet weak var playBackView: UIView!
    @IBOutlet weak var playOrPauseButton: UIButton!
    let viewModel = PlaybackViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        logger.enter()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addPlayer()

//        Observable.combineLatest(viewModel.player.rx.timeControlStatus, Observable<Int>.interval(.milliseconds(350), scheduler: MainScheduler.instance))
//        .map

        Observable.combineLatest(viewModel.player.rx.timeControlStatus,
                                 Observable<Int>.interval(.milliseconds(350), scheduler: MainScheduler.instance))
            .map { $0.0 }
            .subscribe(onNext: { [unowned self] status in
                switch (status) {
                case .playing:
                    self.playOrPauseButton.rx.title(for: .normal).onNext("Pause")
                default:
                    self.playOrPauseButton.rx.title(for: .normal).onNext("Play")
                }
            })
            .disposed(by: disposeBag)

        playOrPauseButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                if self.playOrPauseButton.titleLabel?.text == "Pause" {
                    logger.info("Pause")
                    self.viewModel.player.pause()
                } else {
                    DispatchQueue.main.async(execute: {
                        //                    let timeScale = CMTimeScale(NSEC_PER_SEC)
//                        let current = self.viewModel.player.currentTime()
//                        let time = CMTime(seconds: current.seconds + 3.5, preferredTimescale: 1)
//                        logger.info("current=\(current.seconds) Seek=\(time.seconds)")
//                        self.viewModel.player.seek(to: time, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero, completionHandler: { isFinish in
//                            logger.info("isFinish=\(isFinish)")
//                        })

                        //                    let timeScale = CMTimeScale(NSEC_PER_SEC)
//                        let current = self.viewModel.player.currentTime()
//                        let time = CMTime(seconds: current.seconds - 3.5, preferredTimescale: 1)
//                        logger.info("current=\(current.seconds) Seek=\(time.seconds)")
//                        self.viewModel.player.seek(to: time, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero, completionHandler: { isFinish in
//                            logger.info("isFinish=\(isFinish)")
//                        })

                        guard let duration  = self.viewModel.player.currentItem?.duration else {
                            return
                        }
                        let playerCurrentTime = CMTimeGetSeconds(self.viewModel.player.currentTime())
                        let newTime = playerCurrentTime + 10

                        if newTime < CMTimeGetSeconds(duration) {

                            let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
//                            self.viewModel.player.seek(to: time2)
                            self.viewModel.player.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero, completionHandler: { isFinish in
                                logger.info("isFinish=\(isFinish)")
                            })

                        } else {
                            logger.info("Over duration")
//                            let playerEndTime = CMTimeGetSeconds(duration)
//                            let time2: CMTime = CMTimeMake(value: Int64((playerEndTime * 1000 - 1) as Float64), timescale: 1000)
//                            //                            self.viewModel.player.seek(to: time2)
//                            self.viewModel.player.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero, completionHandler: { isFinish in
//                                logger.info("isFinish=\(isFinish)")
//                            })
                        }

                    })
                }
            })
            .disposed(by: disposeBag)

        logger.exit()
    }

    override func viewDidAppear(_ animated: Bool) {
        logger.enter()
        super.viewDidAppear(animated)

        play()
        logger.exit()
    }

    func addPlayer() {
        logger.enter()
        viewModel.prepareToPlay(url: (viewModel.urlPlay.value)!)

        let playerLayer = AVPlayerLayer(player: viewModel.player)
        playerLayer.frame = playBackView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playBackView.layer.addSublayer(playerLayer)

        logger.exit()
    }

    func play() {
        logger.enter()
        viewModel.player.play()
        logger.exit()
    }

}
