//
//  MainViewController.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 14/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NetworkPlatform

class MainViewController: UIViewController {

    @IBOutlet weak var apiGithubButton: UIButton!
    let disposeBag = DisposeBag()
    let viewModel = MainViewModel()
    override func viewDidLoad() {
        logger.enter()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        apiGithubButton.rx.tap
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.tapAPIGitHubButton()
            })
            .disposed(by: disposeBag)

        viewModel.action
            .observeOn(ConcurrentMainScheduler.instance)
            .subscribe(onNext: { [unowned self] action in
                switch action {
                case .gotoGithub:
                    self.performSegue(withIdentifier: "gotoGithub", sender: self)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)

        logger.exit()
    }

    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
        logger.enter()
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        logger.exit()
    }

}
