//
//  Network.swift
//  NetworkPlatform
//
//  Created by Nguyễn Trọng Anh Tuấn on 20/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import Foundation
//import Alamofire
import RxAlamofire
import RxSwift

final public class Network<T: Decodable> {

    private let scheduler: ConcurrentDispatchQueueScheduler

    public init(_ scheduler: ConcurrentDispatchQueueScheduler
        = ConcurrentDispatchQueueScheduler(
            qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background,
                             relativePriority: 1))) {
        self.scheduler = scheduler
    }

    public func requestGetJSON(urlString: String) -> Observable<T> {
        return RxAlamofire
            .data(.get, urlString)
            .debug()
            .observeOn(scheduler)
            .map({ data -> T in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .secondsSince1970
                return try decoder.decode(T.self, from: data)
            })
    }

//    func getItems(_ path: String) -> Observable<[T]> {
//        let absolutePath = "\(endPoint)/\(path)"
//        return RxAlamofire
//            .data(.get, absolutePath)
//            .debug()
//            .observeOn(scheduler)
//            .map({ data -> [T] in
//                return try JSONDecoder().decode([T].self, from: data)
//            })
//    }

    public func requestPostJSON(urlString: String, parameters: [String: Any] = [:]) -> Observable<T> {
        return RxAlamofire
            .request(.post, urlString, parameters: parameters)
            .debug()
            .observeOn(scheduler)
            .data()
            .map({ data -> T in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .secondsSince1970
                return try decoder.decode(T.self, from: data)
            })
    }

//    func updateItem(_ path: String, itemId: String, parameters: [String: Any]) -> Observable<T> {
//        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
//        return RxAlamofire
//            .request(.put, absolutePath, parameters: parameters)
//            .debug()
//            .observeOn(scheduler)
//            .data()
//            .map({ data -> T in
//                return try JSONDecoder().decode(T.self, from: data)
//            })
//    }
//
//    func deleteItem(_ path: String, itemId: String) -> Observable<T> {
//        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
//        return RxAlamofire
//            .request(.delete, absolutePath)
//            .debug()
//            .observeOn(scheduler)
//            .data()
//            .map({ data -> T in
//                return try JSONDecoder().decode(T.self, from: data)
//            })
//    }
}
