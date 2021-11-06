//
//  WebServiceConfig.swift
//  MultiLvlJsonAPIDemo
//
//  Created by Ravi Patel on 02/08/21.
//

import Foundation

let isBeta = false
let liveUrl = "https://g.tenor.com/v1/"
let betaUrl = "https://g.tenor.com/v1/"

let BASEURL = isBeta ? betaUrl : liveUrl

struct API {
    static let search = "search"
}
