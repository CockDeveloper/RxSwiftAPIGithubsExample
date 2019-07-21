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

        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
//        automaticallyAdjustsScrollViewInsets = false

        let cellType = GHUsersAllTableViewCell.self
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

extension GHUsersAllViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        logger.enter()
        let headerView = UITableViewHeaderFooterView()
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.green
        headerView.backgroundView = backgroundView
        logger.exit("view=\(headerView)")
        return headerView
    }

}
