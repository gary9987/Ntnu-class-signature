//
//  SignViewController.swift
//  Ntnu-class-signature
//
//  Created by Guan Ying Chen on 2020/3/5.
//  Copyright © 2020 Guan Ying Chen. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SignViewController: UIViewController {

    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var classroomTextField: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let model = SignViewModel()
        
        classroomTextField.rx.textInput.text.orEmpty.asObservable().subscribe(onNext: {text in
            
            model.classroom = text
            
        }).disposed(by: disposeBag)
        
        signButton.rx.tap.subscribe(onNext: { [] in
            
            model.sign()
            
        }).disposed(by: disposeBag)
        
        model.alert.subscribe(onNext: {str in
            
            let alertController = UIAlertController(title: NSLocalizedString("Message", comment: ""), message: NSLocalizedString(str, comment: ""), preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
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
