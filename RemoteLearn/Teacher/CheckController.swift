//
//  OpenExerciseController.swift
//  RemoteLearn
//
//  Created by Konrad on 24/04/2020.
//  Copyright © 2020 Konrad. All rights reserved.
//

import UIKit
import Firebase

class CheckController: UIViewController {
    
    var text : String = "" {
        didSet{
            exerciseBody.text = text
        }
    }
    
    var model : CheckModel = CheckModel()
    var exerciseId : String = ""
    
    var questionView : UIView =  {
       var view = UIView()
        view.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var answerView: UIView =  {
       var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1).cgColor
        view.layer.borderWidth = 4
        return view
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
    
    
    var answerHead : UILabel = {
       var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.text = "Pytanie"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var answerBody : UILabel = {
       var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Treść zadania s dkjans dajns kdjah shd kjas dh kajshdk ajhs dkaj "
        label.textColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        answerBody.text = model.answer
        exerciseBody.text = model.question
        setupViews()
        navigationItem.title = "Odpowiedź"
    }
    func setupViews() {
        
        view.addSubview( questionView)
        view.addSubview( answerView)
        questionView.addSubview(exerciseHead)
        questionView.addSubview(exerciseBody)
        answerView.addSubview(answerBody)
        answerView.addSubview(answerHead)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(\(screenWidth - 20))]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": questionView]))
        view.addConstraint(NSLayoutConstraint.init(item: questionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250))
        view.addConstraint(NSLayoutConstraint.init(item: questionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 160))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(\(screenWidth - 20))]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": answerView]))
        view.addConstraint(NSLayoutConstraint.init(item: answerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250))
        view.addConstraint(NSLayoutConstraint.init(item: answerView, attribute: .top, relatedBy: .equal, toItem: questionView, attribute: .bottom, multiplier: 1.0, constant: 30))
        
        questionView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(\(screenWidth - 40))]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": exerciseHead]))
        questionView.addConstraint(NSLayoutConstraint.init(item: exerciseHead, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
        questionView.addConstraint(NSLayoutConstraint.init(item: exerciseHead, attribute: .top, relatedBy: .equal, toItem: questionView, attribute: .top, multiplier: 1.0, constant: 15))
        
        questionView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0(\(screenWidth - 60))]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": exerciseBody]))
        questionView.addConstraint(NSLayoutConstraint.init(item: exerciseBody, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
        questionView.addConstraint(NSLayoutConstraint.init(item: exerciseBody, attribute: .top, relatedBy: .equal, toItem: exerciseHead, attribute: .top, multiplier: 1.0, constant: 15))
        
        
        answerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(\(screenWidth - 40))]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": answerHead]))
        answerView.addConstraint(NSLayoutConstraint.init(item: answerHead, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
        answerView.addConstraint(NSLayoutConstraint.init(item: answerHead, attribute: .top, relatedBy: .equal, toItem: answerView, attribute: .top, multiplier: 1.0, constant: 15))
        
        answerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0(\(screenWidth - 60))]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": answerBody]))
        answerView.addConstraint(NSLayoutConstraint.init(item: answerBody, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
        answerView.addConstraint(NSLayoutConstraint.init(item: answerBody, attribute: .top, relatedBy: .equal, toItem: answerHead, attribute: .top, multiplier: 1.0, constant: 15))
        
        


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
