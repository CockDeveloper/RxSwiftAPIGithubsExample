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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backBarItem: UIBarButtonItem!

    let viewModel = GHUsersAllViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        logger.enter()
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.contentInsetAdjustmentBehavior = .never
//        automaticallyAdjustsScrollViewInsets = false

//        let cellType = GHUsersAllTableViewCell.self
        let cellType = GHUsersAllSubTableViewCell.self
        let xibSub = UINib(nibName: cellType.name, bundle: Bundle.main)
        tableView.register(xibSub, forCellReuseIdentifier: cellType.reuseIdentifier)

//        viewModel.items
//            .bind(to: tableView.rx.items(cellIdentifier: cellType.reuseIdentifier, cellType: cellType)) { $2.configData(user: $0) }
//            .disposed(by: disposeBag)

        viewModel.items
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: cellType.reuseIdentifier,
                                         cellType: cellType)) { _, user, cell in
                                            cell.configData(user: user)
            }
            .disposed(by: disposeBag)

        viewModel.action
            .subscribeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [unowned self] action in
                switch action {
                case .gotoMain:
                    self.gotoSegue("unwindToMain")
                case .gotoPlayback:
                    self.gotoSegue("gotoPlayback")
                default:
                    break
                }
            })
            .disposed(by: disposeBag)

        backBarItem.rx.tap
            .asObservable()
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.tapBackButton()
            })
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: viewModel.tapCell)
            .disposed(by: disposeBag)

        viewModel.getAllUsers()

        logger.exit()
    }

    func gotoSegue(_ identifier: String) {
        logger.enter()
        DispatchQueue.main.async(execute: { [weak self] in
            self?.performSegue(withIdentifier: identifier, sender: self)
        })
        logger.exit()
    }

}

extension GHUsersAllViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        logger.enter()
        let headerView = UITableViewHeaderFooterView()
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.green
        headerView.backgroundView = backgroundView
        logger.exit()
        return headerView
    }

}
