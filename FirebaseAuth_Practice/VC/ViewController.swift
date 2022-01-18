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
    let phoneNumberTextField = UITextField()
    let verificationNumberTextField = UITextField()
    let requestButton = UIButton()
    let verificationButton = UIButton()
    
    
    //MARK: Method
    @objc func buttonClicked(_ sender: UIButton) {
        let text = phoneNumberTextField.text ?? ""
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("+82 \(text)", uiDelegate: nil) { [weak self](verificationID, error) in
                guard let self = self else { return }
                if let id = verificationID {
                    UserDefaults.standard.set("\(id)", forKey: "verificationID")
                }
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
    }
    
    @objc func verificationButtonClicked(_ sender: UIButton) {
        guard let verificationID = UserDefaults.standard.string(forKey: "verificationID"), let verificationCode = verificationNumberTextField.text else {
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        logIn(credential: credential)
    }
    
    func logIn(credential: PhoneAuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                print("LogIn Failed...")
            }
            print("LogIn Success!!")
            print("\(authResult!)")
        }
    }
    
    func setUp() {
        self.view.addSubview(requestButton)
        requestButton.backgroundColor = .systemBlue
        requestButton.setTitle("인증번호 요청", for: .normal)
        requestButton.setTitleColor(.white, for: .normal)
        requestButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        
        self.view.addSubview(phoneNumberTextField)
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.backgroundColor = .white
        phoneNumberTextField.placeholder = "전화번호 입력"
        phoneNumberTextField.textColor = .black
        
        self.view.addSubview(verificationNumberTextField)
        verificationNumberTextField.backgroundColor = .white
        verificationNumberTextField.textColor = .black
        verificationNumberTextField.keyboardType = .numberPad
        verificationNumberTextField.placeholder = "인증번호 입력"
        
        self.view.addSubview(verificationButton)
        verificationButton.backgroundColor = .systemBlue
        verificationButton.setTitle("인증번호 확인", for: .normal)
        verificationButton.setTitleColor(.white, for: .normal)
        verificationButton.addTarget(self, action: #selector(verificationButtonClicked(_:)), for: .touchUpInside)
    }
    
    func setConstrains() {
        requestButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        phoneNumberTextField.snp.makeConstraints { make in
            make.bottom.equalTo(requestButton.snp.top).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(48)
        }
        verificationNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(requestButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(48)
        }
        
        verificationButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.centerY.equalToSuperview()
        }
    }
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setConstrains()
    }


}

