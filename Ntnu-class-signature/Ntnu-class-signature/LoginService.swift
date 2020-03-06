//
//  LoginService.swift
//  Ntnu-class-signature
//
//  Created by Guan Ying Chen on 2020/3/6.
//  Copyright © 2020 Guan Ying Chen. All rights reserved.
//

import Foundation
import RealmSwift

class LoginService {
    
    static let getInstance = LoginService()
    
    static let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    static let filePath = documentPath?.appending("/dbll.realm")
    static let url = URL(fileURLWithPath: filePath!)
    
    func isLogin() -> Bool {
        
        let realm = try! Realm(fileURL: LoginService.url)
        let list = realm.objects(LoginInfo.self)
        if ( list.count != 0 && list[0].status == true){
            return  true
        }
        else {
            return false
        }
        
    }
    
    func login(id: String, pwd:String, status: Bool) {
        
        let realm = try! Realm(fileURL: LoginService.url)
        
        let info = LoginInfo(id: id, pwd: pwd, status: status)
        
        try! realm.write {
            realm.add(info, update: .all)
        }
        
    }
    
    func logout(){
        
        let realm = try! Realm(fileURL: LoginService.url)
        
        let info = LoginInfo(id: "", pwd: "", status: false)
        
        try! realm.write {
            realm.add(info, update: .all)
        }
        
    }
    
    func getID() -> String? {
        
        let realm = try! Realm(fileURL: LoginService.url)
        let list = realm.objects(LoginInfo.self)
        if(list.count != 0 ){
            return list[0].uid
        }
        return nil
        
    }
    func getPassword() -> String? {
        
        let realm = try! Realm(fileURL: LoginService.url)
        let list = realm.objects(LoginInfo.self)
        if(list.count != 0 ){
            return list[0].password
        }
        return nil
        
    }
    
    
    
    
}

class LoginInfo: Object {
    // For realm
    internal required init(){
        
    }
    @objc dynamic var uuid = "CFAF8EBB-CF9A-4999-ACA8-F64A7D58424B"
    override static func primaryKey() -> String? {
        return "uuid"
    }
    // End
    
    init(id: String, pwd:String, status:Bool) {
        uid = id
        password = pwd
        self.status = status
    }
    
    @objc dynamic var uid = ""
    @objc dynamic var password = ""
    @objc dynamic var status = false
    
}
