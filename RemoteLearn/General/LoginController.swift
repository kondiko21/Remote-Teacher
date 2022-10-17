//
//  LoginController.swift
//  RemoteLearn
//
//  Created by Konrad on 22/04/2020.
//  Copyright © 2020 Konrad. All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import JGProgressHUD

class LoginController: UIViewController, UITextFieldDelegate {
        
    var mailField : UITextField = {
        var field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "jankowalski@abc.com"
        field.layer.cornerRadius = 5.0
        field.layer.borderWidth = 0.5
        field.layer.masksToBounds = true
        field.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        field.borderStyle = .line
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = UITextField.ViewMode.always
        return field
    }()
    
    var mailLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Adres email"
       return label
    }()
    
    var passwordField : UITextField = {
        var field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = ""
        field.layer.cornerRadius = 5.0
        field.layer.borderWidth = 0.5
        field.layer.masksToBounds = true
        field.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        field.borderStyle = .line
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = UITextField.ViewMode.always
        field.isSecureTextEntry = true
        return field
    }()
    
    var passwordLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Hasło"
       return label
    }()
    
    var registerButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor  = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        button.setTitle("Zaloguj się", for: .normal)
        button.addTarget(self, action: Selector(("loginTapped")), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(mailLabel)
        view.addSubview(mailField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        passwordField.delegate = self
        mailField.delegate = self
        
        navigationItem.title = "Logowanie"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem = nil
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        
        setupView()
    }
    
    func setupView() {
        
            //MAIL LABEL
           view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": mailLabel]))
           view.addConstraint(NSLayoutConstraint.init(item: mailLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 200))
           view.addConstraint(NSLayoutConstraint.init(item: mailLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
          
           //MAIL FIELD
           view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": mailField]))
           view.addConstraint(NSLayoutConstraint.init(item: mailField, attribute: .top, relatedBy: .equal, toItem: mailLabel, attribute: .bottom, multiplier: 1.0, constant: 5))
           view.addConstraint(NSLayoutConstraint.init(item: mailField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))
         
           //PASSWORD LABEL
           view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": passwordLabel]))
           view.addConstraint(NSLayoutConstraint.init(item: passwordLabel, attribute: .top, relatedBy: .equal, toItem: mailLabel, attribute: .bottom, multiplier: 1.0, constant: 50))
           view.addConstraint(NSLayoutConstraint.init(item: passwordLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
        
           //PASSWORD FIELD
           view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": passwordField]))
           view.addConstraint(NSLayoutConstraint.init(item: passwordField, attribute: .top, relatedBy: .equal, toItem: passwordLabel, attribute: .bottom, multiplier: 1.0, constant: 5))
           view.addConstraint(NSLayoutConstraint.init(item: passwordField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))
        
        
        //REGISTER BUTTON
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": registerButton]))
        view.addConstraint(NSLayoutConstraint.init(item: registerButton, attribute: .top, relatedBy: .equal, toItem: passwordField, attribute: .bottom, multiplier: 1.0, constant: 20))
        view.addConstraint(NSLayoutConstraint.init(item: registerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 45))
        
           
    }
    
    @objc private func loginTapped(){
        
        let hud = JGProgressHUD(style: .light)
        hud.show(in: view)

        Auth.auth().signIn(withEmail: mailField.text!, password: passwordField.text!) { (user, error) in
            
            if error != nil {
                
                hud.textLabel.text = "Logowanie nie powiodło się, sprawdź czy wprowadzone dane są poprawne 😉"
                hud.show(in: self.view)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 1000000)) {
                    hud.dismiss()
                }
                
            }
            
            else {
                var role : String = ""
                let userID = Auth.auth().currentUser?.uid
                
                Database.database().reference().child("users").child(userID!).child("role").observeSingleEvent(of: .value) { (snap) in
                    print(snap)
                    role = snap.value as! String
                    if (role == "teacher") {
                        self.goToTeacherView()
                                       
                    }
                    else {
                        print("you are student!")
                        self.goToStudentView()
                }
                }

                hud.dismiss()
               
            }
            
            
        }
    }
    
    func goToStudentView() {
        let modal = StudentController()
        navigationItem.backBarButtonItem?.tintColor = .white
        navigationController?.pushViewController(modal, animated: true)
    }
    
    func goToTeacherView() {
        let modal = TeacherController()
        navigationItem.backBarButtonItem?.tintColor = .white
        navigationController?.pushViewController(modal, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordField.resignFirstResponder()
        mailField.resignFirstResponder()
        return true
    }
    
}
