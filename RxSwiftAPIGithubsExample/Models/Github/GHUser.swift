//
//  GHUser.swift
//  RxSwiftAPIGithubsExample
//
//  Created by Nguyễn Trọng Anh Tuấn on 20/07/2019.
//  Copyright © 2019 Cock Developer. All rights reserved.
//

import Foundation

//struct GHUser: Codable {
//    let login: String
//    let id: Int
//    let node_id: String
//    let avatarUrl:String
//    let gravatar_id: String
//    let url: String
//    let htmlUrl:String
//    let followersUrl:String
//    let followingUrl:String
//    let gistsUrl:String
//    let starredUrl:String
//    let subscriptionsUrl:String
//    let organizationsUrl:String
//    let reposUrl:String
//    let eventsUrl:String
//    let received_eventsUrl:String
//    let type: String
//    let site_admin: Bool
//}

struct GHUser: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl:String
    let gravatarId: String
    let url: String
    let htmlUrl:String
    let followersUrl:String
    let followingUrl:String
    let gistsUrl:String
    let starredUrl:String
    let subscriptionsUrl:String
    let organizationsUrl:String
    let reposUrl:String
    let eventsUrl:String
    let receivedEventsUrl:String
    let type: String
    let siteAdmin: Bool
}
