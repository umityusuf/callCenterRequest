//
//  FeedViewController.swift
//  FoursquareCloneFirebase
//
//  Created by ümit yusuf erdem on 5.04.2023.
//

import UIKit
import Firebase

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
  
    var userEmailArray = [String]()
    var userNoArray = [String]()
    var userAreaArray = [String]()
    var userNumberArray = [String]()
    var userExplainArray = [String]()
    var documentIDArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()
        
    }
    
    func getDataFromFirestore() {
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Posts").order(by: "date",descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.userExplainArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userNoArray.removeAll(keepingCapacity: false)
                    self.userNumberArray.removeAll(keepingCapacity: false)
                    self.documentIDArray.removeAll(keepingCapacity: false)
                    self.userAreaArray.removeAll(keepingCapacity: false)
                    
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentIDArray.append(documentID)
                        
                        
                        if let postedBy = document.get("PostedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        
                        if let areaNo = document.get("areaNo") as? String {
                            self.userAreaArray.append(areaNo)
                        }
                        
                        if let explain = document.get("explain") as? String {
                            self.userExplainArray.append(explain)
                        }
                        
                        if let number = document.get("number") as? String {
                            self.userNumberArray.append(number)
                        }
                    
                        if let userNo = document.get("userNo") as? String {
                            self.userNoArray.append(userNo)
                        }
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RequestCell
        cell.userNoText.text = "MYM No: \(userNoArray[indexPath.row])"
        cell.areaNoText.text = "Mahal: \(userAreaArray[indexPath.row])"
        cell.numberText.text = "Dahili Numara: \(userNumberArray[indexPath.row])"
        cell.explainText.text = "Açıklama: \(userExplainArray[indexPath.row])"
        cell.documentIdLabel.text = documentIDArray[indexPath.row]
 
        return cell
    }
    


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.userNoArray.remove(at: indexPath.row)
            self.userNumberArray.remove(at: indexPath.row)
            self.userExplainArray.remove(at: indexPath.row)
            self.userAreaArray.remove(at: indexPath.row)
            
            let firestoreDatabase = Firestore.firestore()
            firestoreDatabase.collection("Posts").document(documentIDArray[indexPath.row]).delete()
        }
        self.tableView.reloadData()
    }
  

    
    



}
