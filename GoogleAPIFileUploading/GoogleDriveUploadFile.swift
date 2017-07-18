//
//  GoogleDriveUploadFile.swift
//  LAFDBrush
//
//  Created by Kahuna on 7/17/17.
//  Copyright © 2017 Kahuna Systems Pvt. Ltd. All rights reserved.
//

import Foundation
import GoogleAPIClientForREST
import Google

class GoogleDriveUploadFile: NSObject {

    static let shareInstance = GoogleDriveUploadFile()
    var driveFile = GTLRDrive_File()

    func createFolder(_ service: GTLRDriveService, folderName: String, callback: @escaping ((Bool, AnyObject?) -> Void)) {
        let metadata = GTLRDrive_File()
        metadata.name = folderName
        metadata.mimeType = "application/vnd.google-apps.folder"
        var query: GTLRDriveQuery? = nil
        query = GTLRDriveQuery_FilesCreate.query(withObject: metadata, uploadParameters: nil)
        query?.fields = "id,name,modifiedTime,mimeType"
        service.executeQuery(query!, completionHandler: { (ticket, files, error) -> Void in
            if let fList = files as? GTLRDrive_File {
                self.driveFile = fList
                callback(true, fList)
            }
        })
    }

    func setUserPermission(_ batchQuery: GTLRBatchQuery, fileId: String, emailAddress: String) {
        let userPermission = GTLRDrive_Permission()
        userPermission.type = "user"
        userPermission.role = "writer"
        userPermission.emailAddress = emailAddress
        let createUserPermission = GTLRDriveQuery_PermissionsCreate.query(withObject: userPermission, fileId: fileId)
        createUserPermission.fields = "id"
        createUserPermission.completionBlock = { (ticket, permission, error) -> Void in
            if let permissionList = permission as? GTLRDrive_Permission {
                print("Permisson ID: \(permissionList.identifier)")
            }
        }
        batchQuery.addQuery(createUserPermission)
    }

    func saveFile(_ parentRef: String, service: GTLRDriveService, fileName: String, callback: @escaping ((Bool, AnyObject?) -> Void)) {
        var uploadParameters: GTLRUploadParameters? = nil
        let paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as? String ?? ""
        //let mimeType = "application/x-sqlite3"
        let mimeType = "image/png"
        let yourArtPath = documentsDirectory.appending("/\(fileName)")
        // Only update the file content if different.
        if let fileContent: Data = FileManager.default.contents(atPath: yourArtPath) {
            uploadParameters = GTLRUploadParameters(data: fileContent, mimeType: mimeType)
            let metadata = GTLRDrive_File()
            metadata.name = fileName
            metadata.mimeType = mimeType
            metadata.parents = [parentRef]
            var query: GTLRDriveQuery? = nil
            query = GTLRDriveQuery_FilesCreate.query(withObject: metadata, uploadParameters: uploadParameters)
            query?.fields = "id,name,modifiedTime,mimeType"
            service.executeQuery(query!, completionHandler: { (ticket, files, error) -> Void in
                if error == nil {
                    callback(true, nil)
                }
            })
        }
    }

    func shareFileToUsers(_ parentRef: String, service: GTLRDriveService, emailAddress: [String], callback: @escaping ((Bool, AnyObject?) -> Void)) {
        let batchQuery = GTLRBatchQuery()
        for email in emailAddress {
            self.setUserPermission(batchQuery, fileId: parentRef, emailAddress: email)
        }
        //self.setUserPermission(batchQuery, fileId: parentRef, emailAddress: "nehrulalhingwe@gmail.com")
        service.executeQuery(batchQuery, completionHandler: { (ticket, batchResult, error) -> Void in
            if let batchResultList = batchResult as? GTLRBatchResult {
                print("batchResultList ID: \(batchResultList)")
                callback(true, nil)
            }
        })
    }

}
