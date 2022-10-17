//
//  ViewController.swift
//  RemoteLearn
//
//  Created by Konrad on 21/04/2020.
//  Copyright © 2020 Konrad. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    var loginButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor  = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        button.setTitle("Zaloguj się", for: .normal)
        button.addTarget(self, action: Selector(("loginTapped")), for: .touchUpInside)
        return button
    }()

    var registerButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor  = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        button.setTitle("Zarejestruj się", for: .normal)
        button.addTarget(self, action: Selector(("registerTapped")), for: .touchUpInside)
        return button
    }()
    
    var logo = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        logo.image = UIImage(named: "Logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        view.addSubview(logo)
        
        setupViews()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Wróć", style: .plain, target: nil, action: nil)
        
    }

    func setupViews() {
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[v0]-80-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": logo]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[v0]-80-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": loginButton]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-80-[v0]-80-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": registerButton]))
        view.addConstraint(NSLayoutConstraint.init(item: registerButton, attribute: .top, relatedBy: .equal, toItem: loginButton, attribute: .bottom, multiplier: 1.0, constant: 20.0))
        
        view.addConstraint(NSLayoutConstraint.init(item: loginButton, attribute: .top, relatedBy: .equal, toItem: logo, attribute: .bottom, multiplier: 1.0, constant: 50.0))
        view.addConstraint(NSLayoutConstraint.init(item: logo, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 80.0))
        view.addConstraint(NSLayoutConstraint.init(item: loginButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0))
        view.addConstraint(NSLayoutConstraint.init(item: registerButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0))
        view.addConstraint(NSLayoutConstraint.init(item: logo, attribute: NSLayoutConstraint.Attribute.height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 450))

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func registerTapped() {
        let modal = RegisterController()
            navigationItem.backBarButtonItem?.tintColor = .white
            navigationController?.pushViewController(modal, animated: true)
        }
    
    @objc func loginTapped() {
        let modal = LoginController()
            navigationItem.backBarButtonItem?.tintColor = .white
            navigationController?.pushViewController(modal, animated: true)
        }

}

