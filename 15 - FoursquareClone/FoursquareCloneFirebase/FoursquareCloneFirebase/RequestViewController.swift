//
//  RequestViewController.swift
//  FoursquareCloneFirebase
//
//  Created by ümit yusuf erdem on 5.04.2023.
//

import UIKit
import Firebase

class RequestViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userNoText: UITextField!
    @IBOutlet weak var areaNoText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var explanationText: UITextField!
    @IBOutlet weak var requestButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let auth = Auth.auth()
        
        if auth.currentUser?.email!.first == "2" {
            requestButton.isHidden = true
        } else {
            requestButton.isHidden = false
        }
        

    }
    
    func makeAlert(alertTitle:String,alertMessage:String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)
    }
    
    
    
    @IBAction func requestButtonClicked(_ sender: Any) {
        
        let firestoreDatabase = Firestore.firestore()
        var firestoreReferance : DocumentReference? = nil
        let firestorePosts = ["userNo": String(self.userNoText.text!), "areaNo":String(self.areaNoText.text!),"number":String(self.numberText.text!),"explain":self.explanationText.text!,"PostedBy":Auth.auth().currentUser!.email!, "date":FieldValue.serverTimestamp()] as [String:Any]
        
        firestoreReferance = firestoreDatabase.collection("Posts").addDocument(data: firestorePosts, completion: { error in
            if error != nil {
                self.makeAlert(alertTitle: "Hata", alertMessage: error?.localizedDescription ?? "Error")
                
                
            } else {
                self.makeAlert(alertTitle: "Başarılı", alertMessage: "Talebiniz iletilmiştir.")
                self.explanationText.text = ""
                self.numberText.text = ""
                self.areaNoText.text = ""
                self.userNoText.text = ""
                self.tabBarController?.selectedIndex = 0
            }
        })
        
        
        
        
    }
    
 
}
