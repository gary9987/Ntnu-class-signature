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
            
            model.login().asObserver().subscribe(onNext: {result in
                
                if(result == true){
                    self.performSegue(withIdentifier: "signView", sender: Any?.self)
                }
                else{
                    let AlertController = UIAlertController(title: NSLocalizedString("Failure", comment: ""), message: NSLocalizedString(model.errorMsg, comment: ""), preferredStyle: .alert)
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default){(_) in self.navigationController?.popViewController(animated: true)}
                    AlertController.addAction(okAction)
                    self.present(AlertController, animated: true, completion: nil)
                }
                
            }).disposed(by: self.disposeBag)
            
            }).disposed(by: disposeBag)
        
        idTextField.rx.textInput.text.subscribe(onNext: { text in
            model.id = text!
            }).disposed(by: disposeBag)
        
        pwdTextField.rx.textInput.text.subscribe(onNext: { text in
            model.password = text!
        }).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
        
        if(LoginService.getInstance.isLogin()){
            
            idTextField.text = LoginService.getInstance.getID()
            pwdTextField.text = LoginService.getInstance.getPassword()
            model.login().asObserver().subscribe(onNext: {result in
                
                if(result == true){
                    self.performSegue(withIdentifier: "signView", sender: Any?.self)
                }
                else{
                    let AlertController = UIAlertController(title: NSLocalizedString("Failure", comment: ""), message: NSLocalizedString(model.errorMsg, comment: ""), preferredStyle: .alert)
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default){(_) in self.navigationController?.popViewController(animated: true)}
                    AlertController.addAction(okAction)
                    self.present(AlertController, animated: true, completion: nil)
                }
                
            }).disposed(by: self.disposeBag)
            
        }
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
