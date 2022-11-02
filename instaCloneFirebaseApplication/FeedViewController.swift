//
//  FeedViewController.swift
//  instaCloneFirebaseApplication
//
//  Created by Berkay on 10.10.2022.
//

import UIKit
import FirebaseFirestore
import SDWebImage
import FirebaseStorage



class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var tableView: UITableView!
    var mailArray = [String]()
    var commentArray = [String]()
    var likesArray = [Int]()
    var imageUrlArray = [String]()
    var documentIdArray = [String]()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // tableView Needs here.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // refreshing the view
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        getDataFromFireStore() // getting all the datas from firebase in viewDidLoad
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        getDataFromFireStore()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    

    func getDataFromFireStore() {
        
        // creating the collection that ordered by date.
        

        
        let fireStoreDataBase = Firestore.firestore()
        fireStoreDataBase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshots, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshots?.isEmpty != true && snapshots?.isEmpty != nil {
                    
                    self.imageUrlArray.removeAll(keepingCapacity: false)
                    self.mailArray.removeAll(keepingCapacity: false)
                    self.likesArray.removeAll(keepingCapacity: false)
                    self.commentArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    for documents in snapshots!.documents {
                        let documentID = documents.documentID
                        self.documentIdArray.append(documentID)
                        
                        if let postedBy = documents.get("postedBy") as? String {
                            self.mailArray.append(postedBy)
                        }
                        if let postComment = documents.get("postComment") as? String {
                            self.commentArray.append(postComment)
                            print(postComment)
                        }
                        if let likes = documents.get("likes")  as? Int {
                            self.likesArray.append(likes)
                        }
                        if let imageUrl = documents.get("imageUrl") as? String {
                            self.imageUrlArray.append(imageUrl)
                        }
                        
                        self.tableView.reloadData() // MOST IMPORTANT ONE ****************************************
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // we need to use Reusable and cast it as its .swift file.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedcell", for: indexPath) as! ProtoCellTableViewCell
        cell.userEmailLabel.text = mailArray[indexPath.row]
        cell.commentLabel.text = commentArray[indexPath.row]
        cell.likeLabel.text = String(likesArray[indexPath.row])
        cell.protoimage.sd_setImage(with: URL(string: self.imageUrlArray[indexPath.row]))
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mailArray.count
    }
}
