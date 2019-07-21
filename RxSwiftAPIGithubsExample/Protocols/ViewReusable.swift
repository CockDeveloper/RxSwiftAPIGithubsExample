//
//  ViewReusable.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 21/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import Foundation

protocol ViewReusable: TypeNamable {
    static var reuseIdentifier: String { get }
}
