//
//  VisitorInputViewController.swift
//  FoodTracker
//
//  Created by Huascar  Montero on 03/06/2018.
//  Copyright © 2018 Huascar  Montero. All rights reserved.
//

import UIKit
import Firebase

class VisitorInputViewController: UIViewController {
    @IBOutlet weak var Male: UIButton!
    @IBOutlet weak var Female: UIButton!
    @IBOutlet weak var Add: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    
    var ages: Array<UIButton>?
    var genders: Array<UIButton>?
    var age: Int?
    var gender: String?
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.genders = [self.Male, self.Female]
        self.ages = [self.one, self.two, self.three, self.four, self.five, self.six, self.seven]
        // Do any additional setup after loading the view.
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ageTapped(_ sender: UIButton) {
        for button in self.ages! {
            button.titleLabel?.textColor = UIColor.gray
        }
        self.setAge(button)
    }
    
    private func setAge(_ button: UIButton) {
        switch(button.currentTitle) {
        case "0 - 10":
            self.age = 10;
            break;
        case "11 - 20":
            self.age = 20;
            break;
        case "21 - 30":
            self.age = 30;
            break;
        case "31 - 40":
            self.age = 40;
            break;
        case "41 - 50":
            self.age = 50;
            break;
        case "51 - 60":
            self.age = 60;
            break;
        case "61 - 70":
            self.age = 70;
            break;
        default: break;
        }
    }
    
    private func setGender(_ button: UIButton) {
        switch(button.currentTitle) {
        case "male":
            self.gender = "male";
            break;
        case "female":
            self.gender = "female";
            break;
        }
    }
    
    @IBAction func genderTapped(_ sender: Any) {
        for button in self.genders! {
           button.titleLabel?.textColor = UIColor.gray
        }
        setGender(sender)
    }
    
    @IBAction func addDate(_ sender: Any) {
            // [START add_ada_lovelace]
            // Add a new document with a generated ID
            var ref: DocumentReference? = nil
            ref = db.collection("visitors").addDocument(data: [
                "date": self.gender,
                "age": self.age
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    self.showAlert()
                }
            }
            // [END add_ada_lovelace]
     
    }
    
    private func showAlert() {
    let alert = UIAlertController(title: "Alert", message: "Success", preferredStyle: .alert)
    self.present(alert, animated: true, completion: nil)
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}