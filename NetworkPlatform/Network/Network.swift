//
//  Network.swift
//  NetworkPlatform
//
//  Created by Nguyễn Trọng Anh Tuấn on 20/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

final public class Network<T: Decodable> {

    private let scheduler: ConcurrentDispatchQueueScheduler

    public init(_ scheduler: ConcurrentDispatchQueueScheduler
        = ConcurrentDispatchQueueScheduler(
            qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background,
                             relativePriority: 1))) {
        logger.enter("scheduler=\(scheduler)")
        self.scheduler = scheduler
        logger.exit()
    }

    public func requestGet(urlString: String) -> Observable<Data> {
        logger.enter("urlString=\(urlString)")
        logger.exit()
        return RxAlamofire
            .data(.get, urlString)
            .observeOn(scheduler)
            .debug()
    }

    public func requestGetJSON(urlString: String) -> Observable<T> {
        logger.enter("urlString=\(urlString)")
        logger.exit()
        return requestGet(urlString: urlString)
            .debug()
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
        logger.enter("urlString=\(urlString)")
        logger.exit()
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

    public func requestDownload(urlString: String) -> Observable<String> {
        logger.enter("urlString=\(urlString)")
        let destination: DownloadRequest.DownloadFileDestination = { _, response
            in
            var cachesURL = FileManager.default.urls(for: .cachesDirectory,
                                                   in: .userDomainMask)[0]
            let filename = response.suggestedFilename ?? "\(urlString.hash).tmp"
            cachesURL.appendPathComponent(filename)

            return (cachesURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        logger.exit()
        return RxAlamofire
            .download(URLRequest(url: URL(string: urlString)!), to: destination)
            .debug()
            .observeOn(scheduler)
            .map({ request in
                Observable<String>.create { observer in
                    request.response(completionHandler: { response in
                        observer.onNext(response.destinationURL?.absoluteString ?? "")
                    })
                    return Disposables.create()
                }
            })
            .debug()
            .flatMap({ $0 })
    }

}
