//
//  ViewController.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 14/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NetworkPlatform

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        logger.enter()
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        Network<[GHUser]>()
            .requestGetJSON(urlString: "https://api.github.com/users")
            .map { String(describing: $0) }
            .observeOn(MainScheduler.instance)
            .bind(to: textView.rx.text)
            .disposed(by: disposeBag)
        logger.exit()
    }

}
