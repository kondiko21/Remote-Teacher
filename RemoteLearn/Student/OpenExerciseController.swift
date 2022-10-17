//
//  OpenExerciseController.swift
//  RemoteLearn
//
//  Created by Konrad on 24/04/2020.
//  Copyright © 2020 Konrad. All rights reserved.
//

import UIKit
import Firebase

class OpenExerciseController: UIViewController, UITextViewDelegate {
    
    let userID = Auth.auth().currentUser?.uid

    var number : String = "" {
        didSet{
            exerciseHead.text = "Zadanie \(number)"
        }
    }
    
    var text : String = "" {
        didSet{
            exerciseBody.text = text
        }
    }
    
    var setId : String = ""    
    var exerciseId : String = ""
    
    var questionView : UIView =  {
       var view = UIView()
        view.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var answerField : UITextView = {
        var field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 0.5
        field.layer.masksToBounds = true
        field.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        field.textColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        return field
    }()
    
    var exerciseHead : UILabel = {
       var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.text = "Pytanie"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var exerciseBody : UILabel = {
       var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Treść zadania s dkjans dajns kdjah shd kjas dh kajshdk ajhs dkaj "
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sendButton : UIButton = {
           var button = UIButton()
           button.translatesAutoresizingMaskIntoConstraints = false
           button.layer.cornerRadius = 10
           button.backgroundColor  = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
           button.setTitle("Wyślij", for: .normal)
           button.addTarget(self, action: Selector(("sendTapped")), for: .touchUpInside)
           return button
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.answerField.addDoneButton(title: "Ukryj", target: self, selector: #selector(tapDone(sender:)))

        setupViews()
    }
    func setupViews() {
        
        view.addSubview( questionView)
        view.addSubview( answerField)
        view.addSubview(sendButton)
        questionView.addSubview(exerciseHead)
        questionView.addSubview(exerciseBody)
        answerField.delegate = self
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(\(screenWidth - 20))]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": questionView]))
        view.addConstraint(NSLayoutConstraint.init(item: questionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250))
        view.addConstraint(NSLayoutConstraint.init(item: questionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 120))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(\(screenWidth - 20))]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": answerField]))
        view.addConstraint(NSLayoutConstraint.init(item: answerField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250))
        view.addConstraint(NSLayoutConstraint.init(item: answerField, attribute: .top, relatedBy: .equal, toItem: questionView, attribute: .bottom, multiplier: 1.0, constant: 30))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(\(screenWidth - 20))]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": sendButton]))
        view.addConstraint(NSLayoutConstraint.init(item: sendButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        view.addConstraint(NSLayoutConstraint.init(item: sendButton, attribute: .top, relatedBy: .equal, toItem: answerField, attribute: .bottom, multiplier: 1.0, constant: 30))
        
        questionView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(\(screenWidth - 40))]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": exerciseHead]))
        questionView.addConstraint(NSLayoutConstraint.init(item: exerciseHead, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
        questionView.addConstraint(NSLayoutConstraint.init(item: exerciseHead, attribute: .top, relatedBy: .equal, toItem: questionView, attribute: .top, multiplier: 1.0, constant: 15))
        
        questionView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0(\(screenWidth - 60))]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": exerciseBody]))
        questionView.addConstraint(NSLayoutConstraint.init(item: exerciseBody, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
        questionView.addConstraint(NSLayoutConstraint.init(item: exerciseBody, attribute: .top, relatedBy: .equal, toItem: exerciseHead, attribute: .top, multiplier: 1.0, constant: 15))
        
        


    }
    
    @objc func sendTapped() {
        
        print("WYKONANO: \(exerciseId), \(userID)")
        var answer = answerField.text
        Database.database().reference().child("sets").child(setId).child("results").child(userID!).updateChildValues([exerciseId : answer])
        
        Database.database().reference().child("users").child(userID!).child("sets").child(setId).updateChildValues([exerciseId : true])
        dismiss(animated: true, completion: nil)
    }

     @objc func tapDone(sender: Any) {
           self.view.endEditing(true)
       } 
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"  // Recognizes enter key in keyboard
        {
            answerField.resignFirstResponder()
            return false
        }
        return true
    }

}
