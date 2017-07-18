//
//  DashboardViewController+GoogleDriveUploadFile.swift
//  LAFDBrush
//
//  Created by Kahuna on 7/17/17.
//  Copyright © 2017 Kahuna Systems Pvt. Ltd. All rights reserved.
//

import Foundation
import GoogleSignIn
import GoogleAPIClientForREST
import MBProgressHUD

extension ViewController {

    func setGoogleDriveScope() {
        let signIn = GIDSignIn.sharedInstance()
        signIn?.delegate = self
        signIn?.uiDelegate = self
        var scopes = [String]()
        scopes.append(kGTLRAuthScopeDrive)
        signIn?.scopes = scopes
        signIn?.signIn()
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            self.showAlertViewMessage(message: (error?.localizedDescription)!, title: "Authentication Error")
            service.authorizer = nil
        } else {
            self.customIndicator(0.0, stringText: Constants.Strings.creatingDBText)
            self.dbUploadFileCounter = 0
            service.authorizer = user.authentication.fetcherAuthorizer()
            let sharedInstance = GoogleDriveUploadFile.shareInstance
            let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
            var folderName = "\(appName)_DBBackUp_".appending(Utils.convertFromDate(date: Date()))
            folderName = folderName.replacingOccurrences(of: " ", with: "_")
            sharedInstance.createFolder(service, folderName: folderName, callback: responseFolderFromDrive)
        }
    }

    func responseFolderFromDrive(success: Bool, result: AnyObject?) {
        distroyHUD()
        if success, let _ = result as? GTLRDrive_File {
            self.dbUploadFileCounter = 0
            let floatValue = Double(self.dbUploadFileCounter) * 0.2 + 0.1
            self.customIndicator(Float(floatValue), stringText: Constants.Strings.uploadingDBText + "(\(self.dbUploadFileCounter + 1)/\(self.totalDBUploadFileCounter))")
            let sharedInstance = GoogleDriveUploadFile.shareInstance
            sharedInstance.saveFile(sharedInstance.driveFile.identifier!, service: service, fileName: self.getDBName(index: self.dbUploadFileCounter), callback: uploadNextFileToDrive)
        }
    }

    func getDBName(index: Int) -> String {
        if index == 0 {
            return "uploadImage.png"
        }
        return "uploadImage.png"
    }

    func responseFileFromDrive(success: Bool, result: AnyObject?) {
        distroyHUD()
        if success && self.dbUploadFileCounter < self.totalDBUploadFileCounter {
            let floatValue = Double(self.dbUploadFileCounter) * 0.2 + 0.1
            self.customIndicator(Float(floatValue), stringText: Constants.Strings.uploadingDBText + "(\(self.dbUploadFileCounter + 1)/\(self.totalDBUploadFileCounter))")
            let sharedInstance = GoogleDriveUploadFile.shareInstance
            sharedInstance.saveFile(sharedInstance.driveFile.identifier!, service: service, fileName: self.getDBName(index: self.dbUploadFileCounter), callback: uploadNextFileToDrive)
        }
    }

    func uploadNextFileToDrive(success: Bool, result: AnyObject?) {
        distroyHUD()
        if success {
            if self.totalDBUploadFileCounter > self.dbUploadFileCounter + 1 {
                self.dbUploadFileCounter += 1
                self.responseFileFromDrive(success: success, result: result)
            } else {
                let sharedInstance = GoogleDriveUploadFile.shareInstance
                let emailAddress = ["Your Email Addresses"]
                let floatValue = Double(self.dbUploadFileCounter + 1) * 0.2 + 0.1
                self.customIndicator(Float(floatValue), stringText: Constants.Strings.sharingFileToUsers)
                sharedInstance.shareFileToUsers(sharedInstance.driveFile.identifier!, service: service, emailAddress: emailAddress, callback: responseSharingFileToUsers)
            }
        }
    }

    func distroyHUD() {
        if self.hud != nil {
            if self.ylProgress != nil {
                self.ylProgress = nil
            }
            if self.customIndicatorLabel != nil {
                self.customIndicatorLabel = nil
            }
            self.hud = nil
        }
    }

    func responseSharingFileToUsers(success: Bool, result: AnyObject?) {
        if success {
            self.dbUploadFileCounter = 0
            self.customIndicator(1.0, stringText: Constants.Strings.sharingFileToUsers)
            distroyHUD()
            MBProgressHUD.hideAllHUDs(for: view, animated: true)
            self.showAlertViewMessage(message: "", title: "DBBackup shared successfully")
        }
    }

    @IBAction func uploadDBClickedToDrive(_ sender: UIButton) {
        self.setGoogleDriveScope()
    }

}
