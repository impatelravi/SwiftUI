//
//  WSHandler.swift
//  MultiLvlJsonAPIDemo
//
//  Created by Ravi Patel on 02/08/21.
//

import Foundation
import Alamofire

typealias WSBlock = (_ json: [String:Any],_ flag: Int) -> ()

class WSHandler: NSObject {
    //MARK:- Blocks
    var successBlock: (String, AFDataResponse<Any>, WSBlock) -> Void
    var errorBlock: (String, NSError, WSBlock) -> Void
    
    //MARK:- Initilizer WShandler
    override init() {
        successBlock = { (relativePath, respObj, block) -> Void in
            if respObj.response?.statusCode == 200 {
                block(respObj.value as? [String : Any] ?? [:], (respObj.response?.statusCode)!)
            } else if respObj.response?.statusCode == 401 {
                block(respObj.value as? [String : Any] ?? [:], 200)
            } else if ((respObj.response?.statusCode == 404) && !(getString(anything: (respObj.value as? [String : Any])?[CommonAPIConstant.key_message]).isEmptyString)) {
                block(respObj.value as? [String : Any] ?? [:], 200)
            } else if ((respObj.response?.statusCode == 201) && !(getString(anything: (respObj.value as? [String : Any])?[CommonAPIConstant.key_message]).isEmptyString)) {
                block(respObj.value as? [String : Any] ?? [:], 200)
            } else if (respObj.response?.statusCode == 500) {
                block(respObj.value as? [String : Any] ?? [:], 200)
            } else if (respObj.response?.statusCode == 404) {
                block(respObj.value as? [String : Any] ?? [:], 200)
            } else {
                block(respObj.value as? [String : Any] ?? [:], (respObj.response?.statusCode) ?? 0)
            }
        }
        errorBlock = { (relativePath, error, block) -> Void in
            if let data = error.userInfo["com.alamofire.serialization.response.error.data"] as? NSData {
                let errorDict = (try? JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary
                if errorDict != nil {
                    DebugLog("Error(\(relativePath)): \(errorDict!)")
                    block(errorDict as? [String : Any] ?? [:], error.code)
                    
                } else {
                    let msg = "Something went wrong. Please try again after some time"
                    block(["errormsg" : msg], error.code)
                    DebugLog(msg)
                }
            } else if error.code == -1009 { // happenes when no internet
                DebugLog("Error Object: \(error)")
                block(["errormsg" : "Connection Error"], error.code)
                return
            } else if error.code == -1003  { // happenes when slow internet or slow server
                block(["errormsg": "Internet connection is not available. Please turn on cellular data or correct Wi-Fi settings" as AnyObject], error.code)
                return
            } else if error.code == -1001  { // happenes when slow internet or slow server
                DebugLog("Error Object: \(error)")
                block(["errormsg": "Connection time out. Please check your internet connection and try again"], error.code)
                return
            } else {
                if(error.localizedDescription != "") {
                    block(["errormsg" : "Something went wrong. Please try again after some time"], error.code)
                } else {
                    block(["errormsg" : "Something went wrong. Please try again after some time"], error.code)
                }
            }
        }
        super.init()
    }
    
    static let shared = WSHandler()
}

extension WSHandler {
    func getWebRequest(urlStr: String, param: [String : Any]?, block: @escaping WSBlock) {
        let request = AF.request(urlStr, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil)
        request.responseJSON { (response) in
            DebugLog(response)
            switch response.result {
            case .success(_):
                self.successBlock(urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }
    
    func postWebRequest(urlStr: String, param: [String : Any]?, block: @escaping WSBlock) {
        AF.request(urlStr, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            DebugLog(response)
            switch response.result {
            case .success(_):
                self.successBlock(urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }
}

//MARK:- Check Internet Connectivity
extension WSHandler {
    func CheckInternetConnectivity() -> Bool {
        let reachability:Reachability = Reachability()!
        return reachability.isReachable
    }
}
