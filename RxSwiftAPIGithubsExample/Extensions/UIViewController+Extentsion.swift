//
//  UIViewController+Extentsion.swift
//  RxSwiftRealmExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 26/06/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func hideKeyboardWhenTappedAround() {
        let tapInView = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tapInView.cancelsTouchesInView = false
        view.addGestureRecognizer(tapInView)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

protocol TypeNameable {
    static var typeName: String {get}
}

extension TypeNameable {
    static var typeName: String {
        return String(describing: self)
    }
}

protocol UIViewControllerNameable: TypeNameable {
}

extension UIViewController: UIViewControllerNameable {
}
