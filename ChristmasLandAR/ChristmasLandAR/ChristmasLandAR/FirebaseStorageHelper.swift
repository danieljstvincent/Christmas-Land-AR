//
//  FirebaseStorageHelper.swift
//  ChristmasLandAR
//
//  Created by Daniel St Vincent on 11/11/21.
//

import Foundation
import Firebase

class FirebaseStorageHelper {
    static private let cloudStorage = Storage.storage()
    
    class func asyncDownloadToFilesystem(relativePath: String, handler: @escaping (_ fileUrl: URL) -> Void) {
        // Create local filesystem URL
        let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileUrl = docsUrl.appendingPathComponent(relativePath)
        
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            handler(fileUrl)
            return
        }
        
        // Create a reference to the asset
        let storageRef = cloudStorage.reference(withPath: relativePath)
        
        //Download to the local filesystem
        storageRef.write(toFile: fileUrl) { url, error in
            guard let localUrl = url else {
                print("Firebase storage: Error downloading file with relatePath: \(relativePath)")
                return
            }
            handler(localUrl)
        }.resume()
    }
}
