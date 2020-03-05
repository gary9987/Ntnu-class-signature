//
//  LoginViewMode.swift
//  Ntnu-class-signature
//
//  Created by Guan Ying Chen on 2020/3/5.
//  Copyright © 2020 Guan Ying Chen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class LoginViewMode {
    
    let loginAPI = "http://iportalws.ntnu.edu.tw/login.do"
    
    func login() {
        
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
        
        AF.request("http://iportalws.ntnu.edu.tw/sessionCheckApp.do", method: .post, encoding: URLEncoding.default, headers: headers).responseString { res in
            debugPrint(res)
            
            let parameters = [
                "muid": "40647027s",
                "mpassword": "gary0206",
                "forceMobile": "app",
                "deviceType": "ios",
                "deviceID": "41CDDB1F-8D79-4D32-BB84-3470F0FB07A7",
                "deviceToken": "98478572a4be5b3591022f57d6981fe933ff8c27d1d44b8b8baf218783a51cc8",
            ]
            
            let url = URL(string: self.loginAPI)
            AF.request(url!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseString { response in
                
                if(response.response?.statusCode == 200) {
                    debugPrint(response)
                    debugPrint("Success")
                    
                }
                else{
                    debugPrint("Failure")
                }
                
            }
        }
        
    }
    
}
