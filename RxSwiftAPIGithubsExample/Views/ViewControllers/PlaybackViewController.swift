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
import NetworkPlatform

class PlaybackViewController: UIViewController {

    @IBOutlet weak var playBackView: UIView!
    @IBOutlet weak var playOrPauseButton: UIButton!
    @IBOutlet weak var rightView: UIView!
    let viewModel = PlaybackViewModel()
    let disposeBag = DisposeBag()

    deinit {
        logger.enter()
        viewModel.disposeDowload?.dispose()
        logger.exit()
    }

    override func viewDidLoad() {
        logger.enter()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.urlPlay
            .skip(1)
            .subscribeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [unowned self] _ in
                self.addPlayer()
            })
            .disposed(by: disposeBag)
//        addPlayer()

//        Observable.combineLatest(viewModel.player.rx.timeControlStatus, Observable<Int>.interval(.milliseconds(350), scheduler: MainScheduler.instance))
//        .map

//        Observable.combineLatest(viewModel.player.rx.timeControlStatus,
//                                 Observable<Int>.interval(.milliseconds(350), scheduler: MainScheduler.instance))
//            .map { $0.0 }
//            .subscribe(onNext: { [unowned self] status in
//                switch (status) {
//                case .playing:
//                    self.playOrPauseButton.rx.title(for: .normal).onNext("Pause")
//                default:
//                    self.playOrPauseButton.rx.title(for: .normal).onNext("Play")
//                }
//            })
//            .disposed(by: disposeBag)

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

        viewModel.downloadVideo()

//        let titleNavView = UIView()
//        titleNavView.addSubview(rightView)
//        rightView.translatesAutoresizingMaskIntoConstraints = false
//        rightView.topAnchor.constraint(greaterThanOrEqualTo: titleNavView.topAnchor).isActive = true
//        rightView.bottomAnchor.constraint(greaterThanOrEqualTo: titleNavView.bottomAnchor).isActive = true
//        rightView.leadingAnchor.constraint(equalTo: titleNavView.leadingAnchor).isActive = true
//        rightView.trailingAnchor.constraint(greaterThanOrEqualTo: titleNavView.trailingAnchor).isActive = true
//        rightView.centerYAnchor.constraint(equalTo: titleNavView.centerYAnchor).isActive = true

//        let label = rightView.subviews[1]
//        titleNavView.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.topAnchor.constraint(greaterThanOrEqualTo: titleNavView.topAnchor).isActive = true
//        label.bottomAnchor.constraint(greaterThanOrEqualTo: titleNavView.bottomAnchor).isActive = true
//        label.leadingAnchor.constraint(equalTo: titleNavView.leadingAnchor).isActive = true
//        label.trailingAnchor.constraint(greaterThanOrEqualTo: titleNavView.trailingAnchor).isActive = true
//        label.centerYAnchor.constraint(equalTo: titleNavView.centerYAnchor).isActive = true
//
//        navigationController?.navigationBar.topItem?.titleView = titleNavView
        logger.exit()
    }

    override func viewDidAppear(_ animated: Bool) {
        logger.enter()
        super.viewDidAppear(animated)

//        play()

//        let titleNavView = UIView()
//        titleNavView.addSubview(rightView)
//        rightView.translatesAutoresizingMaskIntoConstraints = false
//        rightView.topAnchor.constraint(greaterThanOrEqualTo: titleNavView.topAnchor).isActive = true
//        rightView.bottomAnchor.constraint(greaterThanOrEqualTo: titleNavView.bottomAnchor).isActive = true
//        rightView.leadingAnchor.constraint(equalTo: titleNavView.leadingAnchor).isActive = true
//        rightView.trailingAnchor.constraint(greaterThanOrEqualTo: titleNavView.trailingAnchor).isActive = true
//        rightView.centerYAnchor.constraint(equalTo: titleNavView.centerYAnchor).isActive = true

//        let titleNavView = UIView()
//        let label = rightView.subviews[1]
//        titleNavView.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.topAnchor.constraint(greaterThanOrEqualTo: titleNavView.topAnchor).isActive = true
//        label.bottomAnchor.constraint(greaterThanOrEqualTo: titleNavView.bottomAnchor).isActive = true
//        label.leadingAnchor.constraint(equalTo: titleNavView.leadingAnchor).isActive = true
//        label.trailingAnchor.constraint(greaterThanOrEqualTo: titleNavView.trailingAnchor).isActive = true
//        label.centerYAnchor.constraint(equalTo: titleNavView.centerYAnchor).isActive = true

        let titleNavView = UIView()
        titleNavView.addSubview(rightView)
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.topAnchor.constraint(equalTo: titleNavView.topAnchor).isActive = true
        rightView.bottomAnchor.constraint(equalTo: titleNavView.bottomAnchor).isActive = true
        rightView.leadingAnchor.constraint(equalTo: titleNavView.leadingAnchor).isActive = true
        rightView.trailingAnchor.constraint(equalTo: titleNavView.trailingAnchor).isActive = true
//        rightView.centerYAnchor.constraint(equalTo: titleNavView.centerYAnchor).isActive = true

        navigationController?.navigationBar.topItem?.titleView = titleNavView

//        navigationController?.navigationBar.topItem?.titleView = rightView
        if let imageView = rightView.subviews[0] as? UIImageView {
            Network<String>()
                .requestDownload(urlString: "https://via.placeholder.com/150")
                .map({ (filePath) -> UIImage? in
                    let data = try Data(contentsOf: URL(string: filePath)!)
                    // Not found image.
                    //                let retImage = UIImage(contentsOfFile: filePath)
                    //                return retImage
                    let retImageData = UIImage(data: data)
                    return retImageData
                })
//                .observeOn(ConcurrentMainScheduler.instance)
                .subscribeOn(MainScheduler.asyncInstance)
                .bind(to: imageView.rx.image)
                .disposed(by: disposeBag)
        }

        logger.exit()
    }

    func addPlayer() {
        logger.enter()
        viewModel.prepareToPlay(url: (viewModel.urlPlay.value)!)

        let playerLayer = AVPlayerLayer(player: viewModel.player)
        playerLayer.frame = playBackView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playBackView.layer.addSublayer(playerLayer)

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

        play()

        logger.exit()
    }

    func play() {
        logger.enter()
        viewModel.player.play()
        logger.exit()
    }

}
