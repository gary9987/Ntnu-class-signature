//
//  LoginViewController.swift
//  Ntnu-class-signature
//
//  Created by Guan Ying Chen on 2020/3/5.
//  Copyright © 2020 Guan Ying Chen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = LoginViewMode()

        loginButton.rx.tap.subscribe(onNext: { [] in
            
            model.login()
            
            }).disposed(by: disposeBag)
        
        idTextField.rx.textInput.text.subscribe(onNext: { text in
            model.id = text!
            }).disposed(by: disposeBag)
        
        pwdTextField.rx.textInput.text.subscribe(onNext: { text in
            model.password = text!
        }).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
