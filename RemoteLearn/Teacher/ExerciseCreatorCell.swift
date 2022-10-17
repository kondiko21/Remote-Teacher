//
//  PlanCell.swift
//  LessonsPlan
//
//  Created by Konrad on 15/09/2019.
//  Copyright © 2019 Konrad. All rights reserved.
//

import UIKit
import Firebase

class ExerciseCreatorCell: UICollectionViewCell {
    
    var name : String = "" {
        didSet{
            subjectLabel.text = self.name
        }
    }
    
    var bgColor : UIColor = UIColor(red:0.88, green:0.96, blue:1.00, alpha:0.7) {
        didSet{
            cellView.backgroundColor = bgColor
        }
    }
    
    var subjectLabel : UILabel = {
          var label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            label.text = "treść zadania"
            label.textColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
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
        
        setupViews()
        backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                cellView.backgroundColor = .systemGreen
            } else {
                // do opposite color
            }
         }
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
