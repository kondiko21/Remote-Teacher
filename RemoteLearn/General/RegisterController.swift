//
//  registerController.swift
//  RemoteLearn
//
//  Created by Konrad on 21/04/2020.
//  Copyright © 2020 Konrad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import JGProgressHUD
var screenWidth = 0

class RegisterController: UIViewController, UITextFieldDelegate {
    
    let user = Auth.auth().currentUser?.createProfileChangeRequest()
    
    var role : String = "student"
    
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
    
    var nameField : UITextField = {
        var field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Jan"
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
    
    var nameLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Imię"
       return label
    }()
    
    var surnameField : UITextField = {
        var field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Kowalski"
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
    
    var surnameLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Nazwisko"
       return label
    }()
    
    var roleLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Kim jesteś?"
       return label
    }()
    
    var teacherButton : UIView = {
       var view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var studentButton : UIView = {
       var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        return view
    }()
    
    var registerButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor  = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        button.setTitle("Zarejestruj się", for: .normal)
        button.addTarget(RegisterController.self, action: Selector(("registerTapped")), for: .touchUpInside)
        return button
    }()
    
    var studentImg = UIImageView()
    var teacherImg = UIImageView()
    
    
    var teacherlabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = . white
        label.text = "Nauczycielem"
        label.textAlignment = .center
       return label
    }()
    
    var studentLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = . white
        label.textAlignment = .center

        label.text = "Uczniem"
       return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(teacherTapped))
        teacherButton.isUserInteractionEnabled = true
        teacherButton.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(studentTapped))
        studentButton.isUserInteractionEnabled = true
        studentButton.addGestureRecognizer(tap1)
        studentImg.image = UIImage.init(named: "un")
        studentImg.translatesAutoresizingMaskIntoConstraints = false
        teacherImg.image = UIImage.init(named: "nn")
        teacherImg.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.red

        view.addSubview(mailLabel)
        view.addSubview(mailField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(nameField)
        view.addSubview(nameLabel)
        view.addSubview(surnameField)
        view.addSubview(surnameLabel)
        view.addSubview(roleLabel)
        view.addSubview(teacherButton)
        view.addSubview(studentButton)
        view.addSubview(registerButton)
        studentButton.addSubview(studentImg)
        teacherButton.addSubview(teacherImg)
        studentButton.addSubview(studentLabel)
        teacherButton.addSubview(teacherlabel)
        navigationItem.title = "Rejestracja"
        screenWidth = Int(view.bounds.width)
        passwordField.delegate = self
        mailField.delegate = self
        nameField.delegate = self
        surnameField.delegate = self

        setupViews()
        
        
        
    }
    
    func setupViews() {
        //MAIL LABEL
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": mailLabel]))
        view.addConstraint(NSLayoutConstraint.init(item: mailLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 150))
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
        
        //NAME label
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        view.addConstraint(NSLayoutConstraint.init(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: passwordField, attribute: .bottom, multiplier: 1.0, constant: 20))
        view.addConstraint(NSLayoutConstraint.init(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
        
        //NAME FIELD
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameField]))
        view.addConstraint(NSLayoutConstraint.init(item: nameField, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1.0, constant: 5))
        view.addConstraint(NSLayoutConstraint.init(item: nameField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))

        //SURNAME label
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": surnameLabel]))
        view.addConstraint(NSLayoutConstraint.init(item: surnameLabel, attribute: .top, relatedBy: .equal, toItem: nameField, attribute: .bottom, multiplier: 1.0, constant: 20))
        view.addConstraint(NSLayoutConstraint.init(item: surnameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
            
        //SURNAME FIELD
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": surnameField]))
        view.addConstraint(NSLayoutConstraint.init(item: surnameField, attribute: .top, relatedBy: .equal, toItem: surnameLabel, attribute: .bottom, multiplier: 1.0, constant: 5))
        view.addConstraint(NSLayoutConstraint.init(item: surnameField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))
        
        //ROLE LABEL
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": roleLabel]))
        view.addConstraint(NSLayoutConstraint.init(item: roleLabel, attribute: .top, relatedBy: .equal, toItem: surnameField, attribute: .bottom, multiplier: 1.0, constant: 5))
        view.addConstraint(NSLayoutConstraint.init(item: roleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))
        
        //ROLE BUTTONS
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": teacherButton]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": studentButton]))
        view.addConstraint(NSLayoutConstraint.init(item: studentButton, attribute: .top, relatedBy: .equal, toItem: roleLabel, attribute: .bottom, multiplier: 1.0, constant: 5))
        view.addConstraint(NSLayoutConstraint.init(item: teacherButton, attribute: .top, relatedBy: .equal, toItem: studentButton, attribute: .bottom, multiplier: 1.0, constant: 5))
        view.addConstraint(NSLayoutConstraint.init(item: studentButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
        view.addConstraint(NSLayoutConstraint.init(item: teacherButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60))
        studentButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(40)]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": studentImg]))
        studentButton.addConstraint(NSLayoutConstraint.init(item: studentImg, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40))
        studentButton.addConstraint(NSLayoutConstraint.init(item: studentImg, attribute: .left, relatedBy: .equal, toItem: studentButton, attribute: .left, multiplier: 1.0, constant: 10))
        
        teacherButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(40)]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": teacherImg]))
        teacherButton.addConstraint(NSLayoutConstraint.init(item: teacherImg, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40))
        teacherButton.addConstraint(NSLayoutConstraint.init(item: teacherImg, attribute: .left, relatedBy: .equal, toItem: teacherButton, attribute: .left, multiplier: 1.0, constant: 10))
        
        studentButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(40)]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": studentLabel]))
        studentButton.addConstraint(NSLayoutConstraint.init(item: studentLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: CGFloat(screenWidth - 150)))
        studentButton.addConstraint(NSLayoutConstraint.init(item: studentLabel, attribute: .left, relatedBy: .equal, toItem: studentImg, attribute: .right, multiplier: 1.0, constant: 10))
        
        teacherButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(40)]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": teacherlabel]))
        teacherButton.addConstraint(NSLayoutConstraint.init(item: teacherlabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: CGFloat(screenWidth - 150)))
        teacherButton.addConstraint(NSLayoutConstraint.init(item: teacherlabel, attribute: .left, relatedBy: .equal, toItem: teacherImg, attribute: .right, multiplier: 1.0, constant: 10))

        //REGISTER BUTTON
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": registerButton]))
        view.addConstraint(NSLayoutConstraint.init(item: registerButton, attribute: .top, relatedBy: .equal, toItem: teacherButton, attribute: .bottom, multiplier: 1.0, constant: 20))
        view.addConstraint(NSLayoutConstraint.init(item: registerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 45))
        

        
        }
    
        @objc func teacherTapped(){
            print("TAPPED")
            role = "teacher"
            
            teacherButton.layer.borderWidth = 2
            teacherButton.layer.borderColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1).cgColor
            teacherlabel.textColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
            teacherImg.image = UIImage.init(named: "nb")
            teacherButton.backgroundColor = .white
            
            studentButton.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
            studentButton.layer.borderWidth = 0
            studentLabel.textColor = .white
            studentImg.image = UIImage.init(named: "un")
        }

        @objc func studentTapped(){
            print("TAPPEDX")
            studentButton.backgroundColor = .white
            studentButton.layer.borderWidth = 2
            studentButton.layer.borderColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1).cgColor
            studentLabel.textColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
            studentImg.image = UIImage.init(named: "ub")
            role = "student"
            
            teacherButton.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
            teacherButton.layer.borderWidth = 0
            teacherlabel.textColor = .white
            teacherImg.image = UIImage.init(named: "nn")
        }
    
        @objc private func registerTapped(){
            
            let userDatabase = Database.database().reference().child("users")

            let hud = JGProgressHUD(style: .light)
            print(mailField.text!)

            hud.show(in: view)
            
                        Auth.auth().createUser(withEmail: mailField.text!, password: passwordField.text!) { (user, error) in

                if error != nil {

                    hud.textLabel.text = "Błąd przy rejstracji, spróbuj ponownie"
                    hud.show(in: self.view)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 60000)) {
                        hud.dismiss()
                    }
                    print(error!)
                }
                else {

                    hud.dismiss()
                    let alert = UIAlertController(title: "Informacja", message: "Zarejestrowano pomyślnie, proszę się zalogować", preferredStyle: UIAlertController.Style.alert)
                                   alert.addAction(UIAlertAction(title: "Dziękuję", style: .default, handler: { (UIAlertAction) in
                                       alert.dismiss(animated: true, completion: nil)
                                   }))
                    self.present(alert, animated: true, completion: nil)
                    print("Registration successfully!")
                    userDatabase.child((user?.user.uid)!).setValue(["name"    : self.nameField.text!,
                                                                    "surname"   : self.surnameField.text!,
                                                                    "role" : self.role])

                    }

                }
            
            }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mailField.resignFirstResponder()
        nameField.resignFirstResponder()
        surnameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }
}
