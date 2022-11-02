//
//  ProtoCellTableViewCell.swift
//  instaCloneFirebaseApplication
//
//  Created by Berkay on 10.10.2022.
//

import UIKit
import FirebaseFirestore
import FirebaseCore


class ProtoCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var protoimage: UIImageView!
    @IBOutlet weak var documentIdLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        if let countLike = Int(likeLabel.text!) {
            let storeOfLike = ["likes" : countLike+1] as [String : Any]
            firestoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(storeOfLike, merge: true)
        }
    }
    
}
