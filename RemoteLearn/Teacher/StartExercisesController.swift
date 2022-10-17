//
//  StartExercisesController.swift
//  RemoteLearn
//
//  Created by Konrad on 23/04/2020.
//  Copyright © 2020 Konrad. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class StartExercisesController: UIViewController, UITextViewDelegate {
    
    let userID = Auth.auth().currentUser?.uid

    var set = [SetCreatorModel]()
    var setlist = [String]()
    var surname = ""
    var teacherName = ""
    var setid = 0
    var x = ""
    var ref : DatabaseReference?
    var img = UIImage()
    
    var teacherLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Zestaw z przedmiotu:"
        label.textAlignment = .center
       return label
    }()
    
    var teacherNameLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Geografia"
        label.textColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        label.textAlignment = .center
       return label
    }()
    
    var countLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Ilość ćwiczeń:"
        label.textAlignment = .center
       return label
    }()
    
    var countNumberLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.textColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        label.textAlignment = .center
       return label
    }()
    
    var qrImg : UIImageView = {
       var image = UIImageView()
        image.backgroundColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage.init(named: "un")
        return image
    }()
    
    var downloadButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor  = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        button.setTitle("Zatwierdź i przejdź do listy", for: .normal)
        button.addTarget(self, action: Selector(("downloadTapped")), for: .touchUpInside)
        return button
    }()
    
    var codeLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Kod zadania:"
        label.textAlignment = .center
       return label
    }()
    
    var infoLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Informacja dla uczniów:"
        label.textAlignment = .center
       return label
    }()
    
    var noteField : UITextView = {
        var field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 0.5
        field.layer.masksToBounds = true
        field.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        field.textColor = UIColor(red:0.13, green:0.59, blue:0.95, alpha:1)
        return field
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.noteField.addDoneButton(title: "Ukryj", target: self, selector: #selector(tapDone(sender:)))

        navigationItem.title = "Podsumowanie"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(teacherLabel)
        view.addSubview(teacherNameLabel)
        view.addSubview(countLabel)
        view.addSubview(countNumberLabel)
        view.addSubview(qrImg)
        view.addSubview(downloadButton)
        view.addSubview(codeLabel)
        view.addSubview(noteField)
        view.addSubview(infoLabel)
        view.backgroundColor = .white
        noteField.delegate = self
        navigationItem.hidesBackButton = true

        self.setid = Int.random(in: 1..<10000)
        while self.setlist.contains(String(self.setid)) {
            self.setid = Int.random(in: 1..<10000)
        }
        print("SETID: \(self.setid)")
        self.img = self.generateQRCode(from: String(self.setid))!
        self.codeLabel.text = "Twój kod: \(self.setid)"
        self.qrImg.image = self.img
        
        teacherNameLabel.text = set[0].lesson
        countNumberLabel.text = String(set.count)
        print(set)
        
        let alert = UIAlertController(title: "Informacja", message: "Proponujemy zrobić zrzut ekranu i przesłać go swoim uczniom, aby uzyskali dostęp", preferredStyle: UIAlertController.Style.alert)
                       alert.addAction(UIAlertAction(title: "Dziękuję", style: .default, handler: { (UIAlertAction) in
                           alert.dismiss(animated: true, completion: nil)
                       }))
        self.present(alert, animated: true, completion: nil)

        setupViews()
    }
    
    func setupViews() {
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": teacherLabel]))
        view.addConstraint(NSLayoutConstraint.init(item: teacherLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 160))
        view.addConstraint(NSLayoutConstraint.init(item: teacherLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": teacherNameLabel]))
        view.addConstraint(NSLayoutConstraint.init(item: teacherNameLabel, attribute: .top, relatedBy: .equal, toItem: teacherLabel, attribute: .top, multiplier: 1.0, constant: 30))
        view.addConstraint(NSLayoutConstraint.init(item: teacherNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": countLabel]))
        view.addConstraint(NSLayoutConstraint.init(item: countLabel, attribute: .top, relatedBy: .equal, toItem: teacherNameLabel, attribute: .top, multiplier: 1.0, constant: 50))
        view.addConstraint(NSLayoutConstraint.init(item: countLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": countNumberLabel]))
        view.addConstraint(NSLayoutConstraint.init(item: countNumberLabel, attribute: .top, relatedBy: .equal, toItem: countLabel, attribute: .top, multiplier: 1.0, constant: 35))
        view.addConstraint(NSLayoutConstraint.init(item: countNumberLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": infoLabel]))
        view.addConstraint(NSLayoutConstraint.init(item: infoLabel, attribute: .top, relatedBy: .equal, toItem: countNumberLabel, attribute: .bottom, multiplier: 1.0, constant: 50))
        view.addConstraint(NSLayoutConstraint.init(item: infoLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": noteField]))
        view.addConstraint(NSLayoutConstraint.init(item: noteField, attribute: .top, relatedBy: .equal, toItem: infoLabel, attribute: .top, multiplier: 1.0, constant: 30))
        view.addConstraint(NSLayoutConstraint.init(item: noteField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
        
        qrImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addConstraint(NSLayoutConstraint.init(item: qrImg, attribute: .top, relatedBy: .equal, toItem: noteField, attribute: .bottom, multiplier: 1.0, constant: 20))
        view.addConstraint(NSLayoutConstraint.init(item: qrImg, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
        view.addConstraint(NSLayoutConstraint.init(item: qrImg, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": codeLabel]))
        view.addConstraint(NSLayoutConstraint.init(item: codeLabel, attribute: .top, relatedBy: .equal, toItem: qrImg, attribute: .bottom, multiplier: 1.0, constant: 10))
        view.addConstraint(NSLayoutConstraint.init(item: codeLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 45))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v0(\(screenWidth - 60))]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": downloadButton]))
        view.addConstraint(NSLayoutConstraint.init(item: downloadButton, attribute: .top, relatedBy: .equal, toItem: codeLabel, attribute: .bottom, multiplier: 1.0, constant: 20))
        view.addConstraint(NSLayoutConstraint.init(item: downloadButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 45))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func downloadTapped(){
        let listView = TeacherController()
        
        Database.database().reference().child("sets").observeSingleEvent(of: .value) { (snap) in
        
        for child in snap.children {
            let snap = child as! DataSnapshot
            let value = snap.key
            self.setlist.append(value)
            }

            Database.database().reference().child("sets").updateChildValues([String(self.setid) : true])
            
            Database.database().reference().child("users").child(self.userID!).child("sets").updateChildValues([String(self.setid) : true])
            
            Database.database().reference().child("sets").child(String(self.setid)).setValue(["lesson" : self.set[0].lesson, "part" : self.set[0].part, "title" : self.set[0].lesson, "note" : self.noteField.text ?? "Brak notatki",  "teacher" : self.userID, "results" : true] )
            
            for exercise in self.set {

                Database.database().reference().child("sets").child(String(self.setid)).child("exercises").updateChildValues([exercise.exercisesId : true])
            }
            
            self.navigationController?.pushViewController(listView, animated: true)

        }
        
        
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    } 

    
}
extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}

