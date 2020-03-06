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
import SwiftyJSON

class LoginViewMode {
    
    let loginAPI = "http://iportalws.ntnu.edu.tw/login.do"
    var id: String = ""
    var password: String = ""
    var errorMsg:String = ""
    let loginStatus = PublishSubject<Bool>()
    
    func checkLoginStatus() {
        
        if(LoginService.getInstance.isLogin()){
            loginStatus.onNext(true)
        }
        else{
            loginStatus.onNext(false)
        }
        
    }
    
    func login() -> PublishSubject<Bool> {
        
        let ret = PublishSubject<Bool>()
        
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
                "muid": self.id,
                "mpassword": self.password,
                "forceMobile": "app",
                "deviceType": "ios",
                "deviceID": "41CDDB1F-8D79-4D32-BB84-3470F0FB07A7",
                "deviceToken": "98478572a4be5b3591022f57d6981fe933ff8c27d1d44b8b8baf218783a51cc8",
            ]
            
            let url = URL(string: self.loginAPI)
            AF.request(url!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseString { response in
                
                if(response.response?.statusCode == 200) {
                    debugPrint(response)
                    
                    do{
                        let json = try JSON(data: response.data!)
                        if(json["success"].boolValue == true){
                            ret.onNext(true)
                            LoginService.getInstance.login(id: self.id, pwd: self.password, status: true)
                        }
                        else{
                            self.errorMsg = json["errorMsg"].stringValue
                            ret.onNext(false)
                        }
                        
                    }
                    catch{
                        ret.onNext(false)
                    }
                    
                }
                else{
                    debugPrint("Failure")
                    ret.onNext(false)
                }
                
                
            }
        }
        return ret
    }
    
}
