//
//  GHUsersAllViewController.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 20/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GHUsersAllViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var backBarItem: UIBarButtonItem!

    let viewModel = GHUsersAllViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        logger.enter()
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        viewModel.items
            .map({ String(describing: $0) })
            .observeOn(MainScheduler.instance)
            .bind(to: textView.rx.text)
            .disposed(by: disposeBag)

        viewModel.action
            .debug("backBarItem GHUserAll")
            .subscribe(onNext: { [unowned self] action in
                switch action {
                case .gotoMain:
                    self.performSegue(withIdentifier: "unwindToMain", sender: self)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)

        backBarItem.rx.tap
            .asObservable()
            .observeOn(ConcurrentMainScheduler.instance)
            .debug("backBarItem")
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.tapBackButton()
            })
            .disposed(by: disposeBag)

        viewModel.getAllUsers()

        logger.exit()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
