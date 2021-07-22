//
//  StorageManager.swift
//  telegram
//
//  Created by Zalkar on 23/7/21.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    public func profilePicUpload(with data: Data,
                                 filename: String,
                                 completion: @escaping (Result<String, Error>) -> Void) {
        
        storage.child("images/\(filename)").putData(data, metadata: nil, completion: {metadata, error in
            guard error == nil else {
                print("Failed to upload")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self.storage.child("images/\(filename)").downloadURL(completion: {url, error in
                guard let url = url else {
                    print("fialed to get iamge url")
                    completion(.failure(StorageErrors.failedToDownloadURL))
                    return
                }
                
                let urlString = url.absoluteString
                print("download url returned\(urlString)")
                completion(.success(urlString))
            })
        })
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToDownloadURL
    }
    
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void){
        let reference = storage.child(path)
        
        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToDownloadURL))
                return
            }
            completion(.success(url))
        })
    }
    
}
