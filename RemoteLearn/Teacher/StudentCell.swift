//
//  PlanCell.swift
//  LessonsPlan
//
//  Created by Konrad on 15/09/2019.
//  Copyright © 2019 Konrad. All rights reserved.
//

import UIKit
import Firebase

class StudentCell: UICollectionViewCell {
    
    let userID = Auth.auth().currentUser?.uid
    var tname : String = ""
    var tsurname : String = ""

    var name : String = "" {
        didSet{
            Database.database().reference().child("users").child(name).child("name").observeSingleEvent(of: .value) { (snap) in
                        self.tname = snap.value as! String
                        print("Imie: \(self.tname)")
            }
            Database.database().reference().child("users").child(name).child("surname").observeSingleEvent(of: .value) { (snap) in
                        self.tsurname = snap.value as! String
                        print(self.tsurname)

                self.subjectLabel.text  = " \(self.tname) \(self.tsurname)"
            }
        }
    }
    
    var subjectLabel : UILabel = {
          var label = UILabel()
           label.font = UIFont.boldSystemFont(ofSize: 32)
           label.text = "Temat zadań"
        label.textColor = .white
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       let cellView : UIView = {
          let view = UIView()
        view.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
           view.translatesAutoresizingMaskIntoConstraints = false
           view.layer.cornerRadius = 5.0
           return view
       }()
    
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cellView)
        cellView.addSubview(subjectLabel)
        
        setupViews()
        backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        
    }
        
    
//MARK: Setting up views
    func setupViews() {
        
        
        cellView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": subjectLabel]))
        cellView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": subjectLabel]))
                
                
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellView]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
