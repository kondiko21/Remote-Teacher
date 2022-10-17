//
//  PlanCell.swift
//  LessonsPlan
//
//  Created by Konrad on 15/09/2019.
//  Copyright © 2019 Konrad. All rights reserved.
//

import UIKit

class SubjectCell: UICollectionViewCell {
    
    var name : String = "" {
        didSet{
            subjectLabel.text = self.name
            teacherImg.image = UIImage.init(named: "\(name)")
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
    
    var teacherImg = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        teacherImg.image = UIImage(named: "nn")
        teacherImg.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cellView)
        cellView.addSubview(subjectLabel)
        cellView.addSubview(teacherImg)
        
        setupViews()
        backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        
    }
        
    
//MARK: Setting up views
    func setupViews() {
        
        
        cellView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(90)]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": teacherImg]))
        cellView.addConstraint(NSLayoutConstraint.init(item: teacherImg, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 90))
        cellView.addConstraint(NSLayoutConstraint.init(item: teacherImg, attribute: .left, relatedBy: .equal, toItem: cellView, attribute: .left, multiplier: 1.0, constant: 10))

        cellView.addConstraint(NSLayoutConstraint.init(item: subjectLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
        cellView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(90)]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": subjectLabel]))
        cellView.addConstraint(NSLayoutConstraint.init(item: subjectLabel, attribute: .left, relatedBy: .equal, toItem: teacherImg, attribute: .right, multiplier: 1.0, constant: 10))
                
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellView]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
