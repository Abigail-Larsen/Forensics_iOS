//
//  FirebaseManager.swift
//  Flash Chat iOS13
//
//  Created by Abigail Thelin on 2/11/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import Combine

struct CaseImgs: Identifiable, Hashable {
    var id: UUID?
    var imgName: String
    var imgTitle: String?
    var imgDescription: String?
}
struct CaseAudio: Identifiable, Hashable {
    var id: UUID?
    var voiceMemo: String
    var voiceMemoTitle: String?
    var localAudioFile: URL
}

struct CaseScan: Identifiable, Hashable {
    var id: UUID?
    var date: String
}


struct Case: Identifiable, Hashable {
    var id: UUID?
    var caseName: String
    var caseNumber: String
}

class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    override init() {
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
}


class CaseGetter: ObservableObject {
    @Published var errorMessage = ""
    @Published var caseImgs = [CaseImgs]()
    @Published var caseScans = [CaseScan]()
    @Published var caseAudios = [CaseAudio]()
    @Published var cases = [Case]()
    private var db = Firestore.firestore()
    
    init() {}
    
    func fetchItems(caseNumber: String) {
        FirebaseManager.shared.firestore.collection("cases").document(caseNumber).collection("images")
            .addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    guard let documents = querySnapshot?.documents else {
                      print("No documents")
                      return
                    }
                    self.caseImgs = documents.compactMap { queryDocumentSnapshot -> CaseImgs? in
                        let data = queryDocumentSnapshot.data()
                        let imgName = data["imgName"] as? String ?? ""
                        let imgTitle = data["imgTitle"] as? String ?? "Untitled Img"
                        let imgDescription = data["imgDescription"] as? String ?? "Lorem Ipsum"
                       return CaseImgs(id: .init(), imgName: imgName, imgTitle: imgTitle, imgDescription: imgDescription)
                    }
                }
            }        
    }
    
    func fetchAudioItems(caseNumber: String) {
        
        FirebaseManager.shared.firestore.collection("cases").document(caseNumber).collection("voiceMemos")
            .addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    guard let documents = querySnapshot?.documents else {
                      print("No documents")
                      return
                    }
                    self.caseAudios = documents.compactMap { queryDocumentSnapshot -> CaseAudio? in
                        let data = queryDocumentSnapshot.data()
                        let voiceMemo = data["voiceMemo"] as? String ?? ""
                        let voiceMemoTitle = data["voiceMemoTitle"] as? String ?? ""
                        let str = voiceMemo.split(separator: "/").last!
                        
                        let fileManager = FileManager.default
                        let documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        let audioFilename = documentPath.appendingPathComponent("\(str).m4a")
                        
                        return CaseAudio(id: .init(), voiceMemo: voiceMemo, voiceMemoTitle: voiceMemoTitle, localAudioFile: audioFilename)
                    }
                }
            }
    }
    
    func fetchAllCases() {
        FirebaseManager.shared.firestore.collection("cases")
            .addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    guard let documents = querySnapshot?.documents else {
                      print("No documents")
                      return
                    }
                    self.cases = documents.compactMap { queryDocumentSnapshot -> Case? in
                        let data = queryDocumentSnapshot.data()
                        let name = data["caseName"] as? String ?? ""
                        let number = data["caseNumber"] as? String ?? ""
                       return Case(id: .init(), caseName: name, caseNumber: number)
                    }
                }
            }
        }
    
    func fetchScans(caseNumber: String) {
        FirebaseManager.shared.firestore.collection("cases").document(caseNumber).collection("scans")
            .addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    guard let documents = querySnapshot?.documents else {
                      print("No documents")
                      return
                    }
                    self.caseScans = documents.compactMap { queryDocumentSnapshot -> CaseScan? in
                        let data = queryDocumentSnapshot.data()
                        let date = data["scanDate"] as? String ?? ""
                        print("DATA", data)
                       return CaseScan(id: .init(), date: date)
                    }
                }
            }
        }
}


class CaseUpdater: ObservableObject {
    private var db = Firestore.firestore()
    
    init() {}
    func addCase(caseName: String, caseNumber: String) {
        db.collection("cases").document(caseNumber).setData(["caseName": caseName, "caseNumber": caseNumber, "date": Date()])
    }
    func addAudioRecording(caseNumber: String, localFile: URL, audioTitle: String) {
        let recordingData: Data! = try? Data(contentsOf:localFile)
        
        let storage = Storage.storage().reference()
        let filename = "case:" + caseNumber + "audioFile:" + String(Float.random(in: 1..<100)) + ".m4a"
        
        storage.child("audio/" + caseNumber + "/" + filename).putData(
            recordingData,
            metadata: nil,
            completion: { _, error in
                guard error == nil else {
                    print("-------------------------failed to upload m4a-------------------------")
                    return
                }
                storage.child("audio/" + caseNumber + "/" + filename).downloadURL { url, err in
                    guard let url = url, error == nil else { return }
                    let urlString = url.absoluteString
                    print("URL STRING", urlString)
                    FirebaseManager.shared.firestore
                        .collection("cases")
                        .document(caseNumber)
                        .collection("voiceMemos")
                        .document(filename)
                        .setData(["voiceMemo": urlString, "voiceMemoTitle": audioTitle])
                    print("DownloadURL: \(urlString)")
                    return
                }
        })
    }
    func updateImgInfo(newTitle: String, newDescription: String, caseNumber: String, imgName: String) {
        print("new Title", imgName, newTitle)
        let str = imgName.split(separator: "/").last!
        let foo = str.split(separator: "?").first!
        let bar = foo.split(separator: "F").last!
        print("BAR CASE IMG", bar)
        db.collection("cases").document(caseNumber).collection("images").document(String(bar)).setData(["imgTitle": newTitle, "imgDescription": newDescription], merge: true)
    }
    func addScan(caseNumber: String) {
        let dateForInfo = Date.now.formatted(date: .long, time: .shortened)
        print("ADDING SCAN TO FIREBASE ")
        db.collection("cases").document(caseNumber).collection("scans").document(dateForInfo).setData(["scanDate": dateForInfo], merge: true)
    }
}
