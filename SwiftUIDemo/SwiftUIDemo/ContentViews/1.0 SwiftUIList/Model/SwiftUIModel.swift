//
//  CollectionViewModel.swift
//  MultiLvlJsonAPIDemo
//
//  Created by Ravi Patel on 02/08/21.
//

import Foundation

class SwiftUIModel: Identifiable {
    //MARK:- Variables
    let results: [SwiftUIResultModel]
    
    enum Keys: String {
        case results = "results"
    }
    
    //MARK:- Initializer
    init(dict: [String : Any]) {
        //results = getString(anything: dict[Keys.results.rawValue])
        let subData = dict[Keys.results.rawValue] as? [Dictionary] ?? []
        results = subData.map( { SwiftUIResultModel(dict: $0) } )
    }
}

class SwiftUIResultModel: Identifiable {
    //MARK:- Variables
    let id: String
    let title: String
    let h1_title: String
    let media: [SwiftUIMediaModel]
    
    enum Keys: String {
        case id = "id"
        case title = "title"
        case h1_title = "h1_title"
        case media = "media"
        
    }
    
    //MARK:- Initializer
    init(dict: [String : Any]) {
        id = getString(anything: dict[Keys.id.rawValue])
        title = getString(anything: dict[Keys.title.rawValue])
        h1_title = getString(anything: dict[Keys.h1_title.rawValue])
        let subData = dict[Keys.media.rawValue] as? [Dictionary] ?? []
        media = subData.map( { SwiftUIMediaModel(dict: $0) } )
    }
}

class SwiftUIMediaModel: Identifiable {
    //MARK:- Variables
    let gifURL: String
    
    enum Keys: String {
        case gif = "gif"
        case url = "url"
    }
    
    //MARK:- Initializer
    init(dict: [String : Any]) {
        self.gifURL = getString(anything: (dict[Keys.gif.rawValue] as? Dictionary)?[Keys.url.rawValue])
    }
}
