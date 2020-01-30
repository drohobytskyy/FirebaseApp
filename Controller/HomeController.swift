//
//  HomeController.swift
//  FireStoreApp
//
//  Created by @rtur drohobytskyy on 29/01/2020.
//  Copyright © 2020 @rtur drohobytskyy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var logoutBtn: UIButton!
    private var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //db = Firestore.firestore()
        setupLayout() 
    }
    
    // MARK: - layout config
    private func setupLayout() {
        
        Utils.shared.customButton(logoutBtn, ButtonTypeEnum.login)
    }
    
    // MARK: - firebse crud
    // add document with auto-generated id
    private func addDocument () {
        //db.collection("users").addDocument(data: ["id": 1, "name": "batman", "email": "batman@batman.com", "active": true, "type": 1])
        
        // same op with closures
        db.collection("users").addDocument(data: ["id": 1, "name": "batman", "email": "batman@batman.com", "active": true, "type": 1]) { (error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("success")
            }
        }
    }
    
    // add document with specific id
    private func addDocument (id: String) {
        db.collection("users").document(id).setData(["id" : 2, "name": "superman", "email": "superman@superman.com", "active": true, "type": 1])
    }
    
    // update document
    private func updateDocument() {
        db.collection("users").document("superman").setData(["id" : 2, "name": "superman", "email": "superman@superman.com", "active": false, "type": 1], merge: true)
    }
    
    // delete document
    private func deleteDocument(id: String) {
        db.collection("users").document(id).delete()
    }
    
    // delete single field
    private func deleteField(fieldName: String) {
        db.collection("users").document("superman").updateData([fieldName: FieldValue.delete()])
    }
    
    // read document
    private func getDocumentById(id: String) {
        db.collection("users").document(id).getDocument { (document, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let document = document {
                    if document.exists {
                        let docData = document.data()
                        print(docData ?? "")
                    } else {
                        print("document doesn't exist")
                    }
                } else {
                    print("could not get document")
                }
            }
        }
    }
    
    // read documents
    private func getAllDocuments() {
        db.collection("users").getDocuments { (documents_data, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let documents_data = documents_data {
                    for document in documents_data.documents {
                        let docData = document.data()
                        print(docData)
                    }
                } else {
                    print("no docs")
                }
            }
        }
    }
    
    // filter documents
    private func getFilteredDocuments(active: Int) {
        db.collection("users").whereField("active", isEqualTo: active).getDocuments { (documents_data, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let documents_data = documents_data {
                    for document in documents_data.documents {
                        let docData = document.data()
                        print(docData)
                    }
                } else {
                    print("no docs")
                }
            }
        }
    }
    
    // MARK: - logout
    @IBAction func logoutAction(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            transitionToInitialController()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    private func transitionToInitialController() {
        
        let initialVc = storyboard?.instantiateViewController(withIdentifier: GlobalConstants.ViewControllers.InitialController) as? ViewController
        
        view.window?.rootViewController = initialVc
        view.window?.makeKeyAndVisible()
    }
}
