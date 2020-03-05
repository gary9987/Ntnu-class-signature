//
//  SignViewModel.swift
//  Ntnu-class-signature
//
//  Created by Guan Ying Chen on 2020/3/5.
//  Copyright © 2020 Guan Ying Chen. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class SignViewModel {
    
    var classroom: String = "B101"
    var alert = PublishSubject<String>()
    
    func sign() {
    
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "App-Version": "1.42",
            "App-Locale": "zh_TW",
            "Host": "iportalws.ntnu.edu.tw",
            "User-Agent": "Direk iOS App",
            "Connection": "keep-alive",
            "Os-Version": "13.3",
            "Phone-Brand": "iPhone 7",
            "Accept": "*/*"
        ]
        
        let parameters = [
            "iconOu": "ntnuScan",
            "iconName" : "QR掃描"
        ]
        
        AF.request("http://iportalws.ntnu.edu.tw/appLogAdd.do", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseString { res in
            debugPrint(res)
            
            let parameters = [
                "apOu": "StuSignin"
            ]
            AF.request("http://iportalws.ntnu.edu.tw/qrSso.do", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseString { res in
                
                let json = try! JSON(data: res.data!)
                debugPrint(json)
                let logId = json["logId"].intValue
                let apUrl = json["apUrl"].stringValue + "&classroom=\(self.classroom)"
                
                debugPrint(self.classroom)
                let buildApiUrl = URL.initPercent(string: apUrl)
                
                AF.request(buildApiUrl, method: .post).responseString { res in
                    debugPrint(res)
                    let json = try! JSON(data: res.data!)
                    debugPrint(json)
                    let msg = json["msg"].stringValue
                    let apResult = json["success"].boolValue
                    
                    let parameters = [
                        "id": logId,
                        "apResult" : apResult,
                        "apResultMsg": msg
                        ] as [String : Any]
                    
                    AF.request("http://iportalws.ntnu.edu.tw/qrSsoResult.do", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseString { res in
                        
                        let json = try! JSON(data: res.data!)
                        debugPrint(json)
                        if(json["success"].boolValue == true) {
                            self.alert.onNext(msg)
                        }
                        else{
                            self.alert.onNext("failure")
                        }
                        
                    }
                }
            }
            
        }
        
    }
}

extension URL{
    
    static func initPercent(string:String) -> URL
    {
        let urlwithPercentEscapes = string.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let url = URL.init(string: urlwithPercentEscapes!)
        return url!
    }
}
