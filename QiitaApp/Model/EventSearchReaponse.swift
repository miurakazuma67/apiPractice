//
//  SearchResponseModel.swift
//  QiitaApp
//
//  Created by 三浦　一真 on 2021/05/04.
//

import Foundation

struct EventSearchResponse: Codable {
    var events: [Event]?
    
    struct Event: Codable {
        var title: String?
    }
}
