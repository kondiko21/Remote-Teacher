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

class StudentController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    let userID = Auth.auth().currentUser?.uid
    let usersDatabase = Database.database().reference().child("users")
    var amountOfSets = 0
    var DBSubject : String = ""
    var DBTeacher : String = ""
    var DBNote : String = ""
    var subjects : [String] = []
    var sets = [SetModel]()
    
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
    
    var numberOfLessons: Int = 1
    var ifEmpty : Bool = false


    override func viewDidLoad() {
           super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Wróć", style: .plain, target: nil, action: nil)
        
        
        print("Countx: \(subjects.count)")
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName:"barcode.viewfinder" ), style: UIBarButtonItem.Style.plain, target: self, action: #selector(scanTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName:"square.and.arrow.up.fill" ), style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutTapped))
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.backgroundColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
              
        
        navigationItem.title = "Zestawy"
        collectionView.register(SetCell.self, forCellWithReuseIdentifier: "mainCell")

        view.addSubview(collectionView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": collectionView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": collectionView]))
        
    
}
    
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         print("XXXX")

        return subjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! SetCell
        
        cell.teacher = sets[indexPath.item].teacher
        cell.name = sets[indexPath.item].subject
        cell.note = sets[indexPath.item].note
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Taped!")
        let modal = ExerciseListController()
            navigationItem.backBarButtonItem?.tintColor = .white
            modal.setsToDisplay = sets[indexPath.item]
            navigationController?.pushViewController(modal, animated: true)
        
    }
    
    @objc func scanTapped() {
        print("Tapped scan button")
        let modal = ScannerController()
        navigationController?.pushViewController(modal, animated: true)
        
    }
    
    @objc func logoutTapped() {
        print("Tapped scan button")
        
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch{
            print("Error while signing out!")
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        sets = []
        subjects = []
        usersDatabase.child(userID!).child("sets").observeSingleEvent(of: .value) { (snap) in
           
            let hud = JGProgressHUD(style: .light)
            hud.show(in: self.view)
             for child in snap.children {
                    let snap = child as! DataSnapshot
                    let value = snap.key
                    let ing = value
                    self.subjects.append(ing)

                Database.database().reference().child("sets").child(ing).observeSingleEvent(of: .value) { (snap) in

                    
                    let data = snap.value as? [String : Any]
                    let tname = data!["teacher"] as? String
                    let tnote = data!["note"] as? String
                    let ttitle = data!["title"] as? String
                    let tlesson = data!["lesson"] as? String
                    let tpart = data!["part"] as? String
                    var exerciseList = [String]()
                    
                    print("Title: \(tlesson) Part: \(tpart)")
                    
                    Database.database().reference().child("sets").child(ing).child("exercises").observeSingleEvent(of: .value) { (snap) in
                                       
                                       for child in snap.children {
                                                          let snap = child as! DataSnapshot
                                                          let value = snap.key
                                                          let ex = value
                                        print(ex)
                                        exerciseList.append(ex)
                                        
                                        }
                        self.sets.append(SetModel(subject: ttitle!, teacher : tname!, note : tnote!, id: ing,exercisesId: exerciseList, lesson: tlesson!, part: tpart!))


                               }
                     print("SETS: \(self.sets)")
    

            }
            
        }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.collectionView.reloadData()
                            hud.dismiss()
            }

        }

    }
    
}
