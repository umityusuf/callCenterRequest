//
//  RequestCell.swift
//  FoursquareCloneFirebase
//
//  Created by ümit yusuf erdem on 6.04.2023.
//

import UIKit
import Firebase

class RequestCell: UITableViewCell {

    @IBOutlet weak var userNoText: UILabel!
    @IBOutlet weak var areaNoText: UILabel!
    @IBOutlet weak var numberText: UILabel!
    @IBOutlet weak var explainText: UILabel!
    @IBOutlet weak var resultExplainText: UITextField!
    @IBOutlet weak var documentIdLabel: UILabel!

    var resultButtonClicked = Bool()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBAction func resultButtonClicked(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Posts").document(documentIdLabel.text!).delete()
        resultExplainText.text = ""
        }
    }
    

