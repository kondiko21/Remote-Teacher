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

class CheckAnswerController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    let userID = Auth.auth().currentUser?.uid
    var lesson : String = ""
    var part : String = ""
    var partList = [String]()
    var name : String = ""
    var setId : String = ""
    var answers = [CheckModel]()
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
        Database.database().reference().child("users").child(name).child("name").observeSingleEvent(of: .value) { (snap) in
                    self.tname = snap.value as! String
                    print("Imie: \(self.tname)")
        }
        Database.database().reference().child("users").child(name).child("surname").observeSingleEvent(of: .value) { (snap) in
                    self.tsurname = snap.value as! String
                    print(self.tsurname)

            self.navigationItem.title = " \(self.tname) \(self.tsurname)"
        }
        
        
        collectionView.register(PartCell.self, forCellWithReuseIdentifier: "mainCell")

        view.addSubview(collectionView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": collectionView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": collectionView]))
        
        Database.database().reference().child("sets").child(setId).child("results").child(name).observeSingleEvent(of: .value) { (snap) in
        let hud = JGProgressHUD(style: .light)
        hud.show(in: self.view)
            
            var questionx : String = ""
        for child in snap.children {
            let snap = child as! DataSnapshot
            let key = snap.key
            let value = snap.value as! String
            
            Database.database().reference().child("exercises").child(self.lesson).child(self.part).child(key).observeSingleEvent(of: .value) { (snap) in
               questionx = snap.value as! String
                self.answers.append(CheckModel(question: questionx, answer: value))

                print("ODPOWIEDZI: \(questionx) \(value)")
            }
            
            
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.collectionView.reloadData()
                            hud.dismiss()
            }
        }
        
    }
    

    
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! PartCell
        cell.name = answers[indexPath.item].question
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("Tapped scan button")
       
        let modal = CheckController()
        modal.model = answers[indexPath.item]
        
        print(answers[indexPath.item])
        
        navigationController?.pushViewController(modal, animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}
