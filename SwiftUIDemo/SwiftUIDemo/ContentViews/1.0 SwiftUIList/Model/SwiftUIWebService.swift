//
//  CollectionViewWebService.swift
//  MultiLvlJsonAPIDemo
//
//  Created by Ravi Patel on 02/08/21.
//

import Foundation

class SwiftUIWebService: NSObject {
    let name = "funny cat"
    let key = "780X74Y20AF8"
    let limit = "100"
    
    public enum Keys:String {
        case q
        case key
        case Limit
    }
    
    fileprivate var url: String {
        return BASEURL + API.search
    }
    
    fileprivate var ColViewdict: [String : Any]? {
        let dict:Dictionary = [Keys.q.rawValue : name,
                               Keys.key.rawValue : key,
                               Keys.Limit.rawValue : limit]
        return dict
    }
    
    func getData(block: @escaping ((SwiftUIModel?) -> Swift.Void)) {
        if WSHandler.shared.CheckInternetConnectivity() {
            WSHandler.shared.getWebRequest(urlStr: url, param: ColViewdict) { (json, flag) in
                var responseModel : SwiftUIModel?
                
                if (flag == 200) {
                    responseModel = SwiftUIModel(dict: json)
                } else {
                    print("Error")
                }
                block(responseModel)
            }
        } else {
            block(nil)
            print("internet issue")
        }
    }
}
