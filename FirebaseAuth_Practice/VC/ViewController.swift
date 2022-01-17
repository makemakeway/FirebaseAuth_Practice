//
//  ViewController.swift
//  FirebaseAuth_Practice
//
//  Created by 박연배 on 2022/01/17.
//

import UIKit
import SnapKit
import FirebaseAuth

class ViewController: UIViewController {

    //MARK: Properties
    
    
    
    //MARK: UI
    let button = UIButton()
    
    
    //MARK: Method
    @objc func buttonClicked(_ sender: UIButton) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("+82 1076071339", uiDelegate: nil)
    }
    
    func setUp() {
        self.view.addSubview(button)
        button.backgroundColor = .systemBlue
        button.setTitle("요청", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }
    
    func setConstrains() {
        button.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
    }
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setConstrains()
    }


}

