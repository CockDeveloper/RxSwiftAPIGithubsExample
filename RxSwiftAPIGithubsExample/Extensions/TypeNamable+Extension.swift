//
//  TypeNamable+Extension.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 21/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import Foundation

extension TypeNamable {
    static var name: String {
        return String(describing: self)
    }
}
