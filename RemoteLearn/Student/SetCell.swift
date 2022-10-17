//
//  PlanCell.swift
//  LessonsPlan
//
//  Created by Konrad on 15/09/2019.
//  Copyright © 2019 Konrad. All rights reserved.
//

import UIKit
import Firebase

class SetCell: UICollectionViewCell {
    
    var tname : String = ""
    var tsurname : String = ""
    
    var name : String = "" {
        didSet{
            subjectLabel.text = self.name
        }
    }
    var teacher : String = "" {
        didSet{
            Database.database().reference().child("users").child(teacher).child("name").observeSingleEvent(of: .value) { (snap) in
                self.tname = snap.value as! String
                print(self.tname)
            }
            Database.database().reference().child("users").child(teacher).child("surname").observeSingleEvent(of: .value) { (snap) in
                self.tsurname = snap.value as! String
                print(self.tsurname)

                self.teacherLabel.text = "Nauczyciel: \(self.tname) \(self.tsurname)"
            }
            
        }
    }
    
    var note : String = "" {
        didSet{
            infoLabel.text = "Informacja:   \(self.note)"
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
       
       var teacherLabel : UILabel = {
          var label = UILabel()
           label.font = UIFont.init(descriptor: .init(), size: 12)
           label.text = "Nauczyciel: Jan Kowalski"
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()

        var infoLabel : UILabel = {
           var label = UILabel()
            label.font = UIFont.init(descriptor: .init(), size: 12)
            label.text = "Proszę o wykonanie jak nawięcej zadań, Pozdrawiam :)"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
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
        cellView.addSubview(teacherLabel)
        cellView.addSubview(infoLabel)
        
        setupViews()
        backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        
    }
        
    
//MARK: Setting up views
    func setupViews() {
        
        cellView.addConstraint(NSLayoutConstraint.init(item: subjectLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20))
        cellView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": subjectLabel]))
        cellView.addConstraint(NSLayoutConstraint.init(item: subjectLabel, attribute: .top, relatedBy: .equal, toItem: cellView, attribute: .top, multiplier: 1.0, constant: 10))
        cellView.addConstraint(NSLayoutConstraint.init(item: subjectLabel, attribute: .left, relatedBy: .equal, toItem: cellView, attribute: .left, multiplier: 1.0, constant: 10))
        
        cellView.addConstraint(NSLayoutConstraint.init(item: teacherLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 15))
        cellView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": teacherLabel]))
        cellView.addConstraint(NSLayoutConstraint.init(item: teacherLabel, attribute: .top, relatedBy: .equal, toItem: subjectLabel, attribute: .bottom, multiplier: 1.0, constant: 5))
        cellView.addConstraint(NSLayoutConstraint.init(item: teacherLabel, attribute: .left, relatedBy: .equal, toItem: cellView, attribute: .left, multiplier: 1.0, constant: 10))
        
        cellView.addConstraint(NSLayoutConstraint.init(item: infoLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        cellView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": infoLabel]))
        cellView.addConstraint(NSLayoutConstraint.init(item: infoLabel, attribute: .top, relatedBy: .equal, toItem: teacherLabel, attribute: .bottom, multiplier: 1.0, constant: -5))
        cellView.addConstraint(NSLayoutConstraint.init(item: infoLabel, attribute: .left, relatedBy: .equal, toItem: cellView, attribute: .left, multiplier: 1.0, constant: 10))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellView]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
