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

class ExerciseListController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    var tname : String = ""
    var tsurname : String = ""
    let userID = Auth.auth().currentUser?.uid
    let usersDatabase = Database.database().reference().child("users")
    var setsToDisplay = SetModel()
    var questionsToSend = [String]()
    
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
        
        print("FetchedData : \(setsToDisplay)")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: false)
              navigationController?.navigationBar.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
              
        
        navigationItem.title = "Zadania"
        collectionView.register(ExerciseCell.self, forCellWithReuseIdentifier: "mainCell")

        view.addSubview(collectionView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": collectionView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": collectionView]))
        
        for id in setsToDisplay.exercisesId {
            
            Database.database().reference().child("exercises").child(setsToDisplay.lesson).child(setsToDisplay.part).child(id).observe(.value) { (snap) in
                
                var data = snap.value as? String
                self.questionsToSend.append(data!)
                self.collectionView.reloadData()
            }
        print("ExerciseID: \(questionsToSend)")
        }
    }
    

    
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         print("XXXX")

        return questionsToSend.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! ExerciseCell
        
        cell.name = questionsToSend[indexPath.item]
        Database.database().reference().child("users").child(setsToDisplay.teacher).child("name").observeSingleEvent(of: .value) { (snap) in
                           self.tname = snap.value as! String
                           print("Imie: \(self.tname)")
                       }
                       Database.database().reference().child("users").child(setsToDisplay.teacher).child("surname").observeSingleEvent(of: .value) { (snap) in
                           self.tsurname = snap.value as! String
                           print(self.tsurname)

                        cell.body.text = "Nauczyciel: \(self.tname) \(self.tsurname)"
                       }
        cell.id = setsToDisplay.id
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("Tapped scan button")
        var id = setsToDisplay.exercisesId[indexPath.item]
        var question : String = questionsToSend[indexPath.item]
        var listOfDone = [String()]
        
        usersDatabase.child(userID!).child("sets").child(setsToDisplay.id).observeSingleEvent(of: .value) { (snap) in
        
        for child in snap.children {
                          let snap = child as! DataSnapshot
                          let value = snap.key
                          let ex = value
                        listOfDone.append(ex)
        
                    }
            print("LIST: \(listOfDone)")
            if (listOfDone.contains(id)) {
                       print("ZROBIONE")
                let alert = UIAlertController(title: "Informacja", message: "Wykonałeś już to zadanie i zostało ono przesłane", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Dziękuję", style: .default, handler: { (UIAlertAction) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
                
                   } else {
                   
                   let modal = OpenExerciseController()
                modal.number = String(indexPath.item + 1)
                   modal.exerciseId = id
                   modal.text = question
                modal.setId = self.setsToDisplay.id
                   modal.modalPresentationStyle = .pageSheet
                   modal.modalTransitionStyle = .coverVertical
                 self.navigationController?.present(modal, animated: true, completion: nil)
                   }
        }
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}
