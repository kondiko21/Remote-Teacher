//
//  DayCell.swift
//  LessonsPlan
//
//  Created by Konrad on 19/09/2019.
//  Copyright © 2019 Konrad. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class StudentListController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    let userID = Auth.auth().currentUser?.uid
    var studentList = [String]()
    var lesson : String = ""
    var part : String = ""
    var setId : String = ""
    
    var tname : String = ""
    var tsurname : String = ""
    
    let collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        view.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        //view.contentInsetAdjustmentBehavior = .never
        view.backgroundColor = .white
        return view

    }()

    override func viewDidLoad() {
           super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "Lista uczniów"
        collectionView.register(StudentCell.self, forCellWithReuseIdentifier: "mainCell")

        view.addSubview(collectionView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": collectionView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": collectionView]))
        
        
    }
    

    
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return studentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! StudentCell
        cell.name = studentList[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("Tapped scan button")
       
        let modal = CheckAnswerController()
        modal.lesson = lesson
        modal.part = part
        modal.name = studentList[indexPath.item]
        modal.setId = setId
        
        navigationController?.pushViewController(modal, animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}
