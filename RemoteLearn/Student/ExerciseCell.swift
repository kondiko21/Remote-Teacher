//
//  PlanCell.swift
//  LessonsPlan
//
//  Created by Konrad on 15/09/2019.
//  Copyright © 2019 Konrad. All rights reserved.
//

import UIKit
import Firebase

class ExerciseCell: UICollectionViewCell {
    
    
    var tname : String = ""
    var tsurname : String = ""
    
    var id : String = ""
    
    var name : String = "" {
        didSet{
            subjectLabel.text = self.name
        }
    }
    var teacherId : String = "" {
        didSet{
                
                Database.database().reference().child("users").child(teacherId).child("name").observeSingleEvent(of: .value) { (snap) in
                    self.tname = snap.value as! String
                    print("Imie: \(self.tname)")
                }
                Database.database().reference().child("users").child(teacherId).child("surname").observeSingleEvent(of: .value) { (snap) in
                    self.tsurname = snap.value as! String
                    print(self.tsurname)

                    self.body.text = "Nauczyciel: \(self.tname) \(self.tsurname)"
                }
            
        }
    }
    
    var subjectLabel : UILabel = {
          var label = UILabel()
           label.font = UIFont.boldSystemFont(ofSize: 20)
           label.text = "Temat zadań"
           label.textColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       var body : UILabel = {
          var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
           label.text = "Nauczyciel: Jan Kowalski"
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       let cellView : UIView = {
          let view = UIView()
           view.backgroundColor = UIColor(red:0.88, green:0.96, blue:1.00, alpha:0.7)
           view.translatesAutoresizingMaskIntoConstraints = false
           view.layer.cornerRadius = 5.0
           return view
       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(cellView)
        cellView.addSubview(subjectLabel)
        cellView.addSubview(body)
        
        setupViews()
        backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        
    }
        
    
//MARK: Setting up views
    func setupViews() {
        
        cellView.addConstraint(NSLayoutConstraint.init(item: subjectLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20))
        cellView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": subjectLabel]))
        cellView.addConstraint(NSLayoutConstraint.init(item: subjectLabel, attribute: .top, relatedBy: .equal, toItem: cellView, attribute: .top, multiplier: 1.0, constant: 10))
        cellView.addConstraint(NSLayoutConstraint.init(item: subjectLabel, attribute: .left, relatedBy: .equal, toItem: cellView, attribute: .left, multiplier: 1.0, constant: 10))
        
        cellView.addConstraint(NSLayoutConstraint.init(item: body, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
        cellView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": body]))
        cellView.addConstraint(NSLayoutConstraint.init(item: body, attribute: .top, relatedBy: .equal, toItem: subjectLabel, attribute: .bottom, multiplier: 1.0, constant: 5))
        cellView.addConstraint(NSLayoutConstraint.init(item: body, attribute: .left, relatedBy: .equal, toItem: cellView, attribute: .left, multiplier: 1.0, constant: 10))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellView]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
