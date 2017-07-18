//
//  ViewController.swift
//  GoogleAPIFileUploading
//
//  Created by Kahuna on 7/18/17.
//  Copyright © 2017 Kahuna. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleAPIClientForREST
import MBProgressHUD
import YLProgressBar

class ViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    var service: GTLRDriveService = GTLRDriveService()
    var dbUploadFileCounter = 0
    var totalDBUploadFileCounter = 2
    var customIndicatorLabel: UILabel!
    var hud: MBProgressHUD!
    var ylProgress: YLProgressBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        var paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory: String = paths[0] as? String ?? ""
        let fileManager = FileManager.default
        let yourArtPath = URL(fileURLWithPath: documentsDirectory).appendingPathComponent("/uploadImage.png")
        if fileManager.fileExists(atPath: yourArtPath.absoluteString) == false {
            let resourcePath = Bundle.main.url(forResource: "uploadImage", withExtension: "png")!
            do {
                try fileManager.copyItem(at: resourcePath, to: yourArtPath)
            } catch let error as NSError {
                print(error.description)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func customIndicator(_ value: Float, stringText: String) {
        if self.hud == nil {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.hud.mode = MBProgressHUDMode.customView
            let mcustomView = Bundle.main.loadNibNamed("ProgressBarIND", owner: self, options: nil)?[0] as! UIView
            self.ylProgress = mcustomView.viewWithTag(11) as! YLProgressBar
            let CancelButton = mcustomView.viewWithTag(44) as! UIButton
            CancelButton.addTarget(self, action: #selector(self.cancelProgressBarButtonClicked(_:)), for: .touchUpInside)
            let buttonLayer = CancelButton.layer
            buttonLayer.masksToBounds = true
            buttonLayer.borderWidth = 2.0
            buttonLayer.cornerRadius = CancelButton.frame.height / 2
            buttonLayer.borderColor = UIColor.white.cgColor
            self.ylProgress.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayMode.progress
            self.ylProgress.stripesDirection = YLProgressBarStripesDirection.left
            self.customIndicatorLabel = mcustomView.viewWithTag(22) as! UILabel
            self.customIndicatorLabel.text = stringText
            self.hud.customView = mcustomView
        }
        if let indicator = self.ylProgress {
            DispatchQueue.main.async { () -> Void in
                indicator.progress = CGFloat(value)
                indicator.progressStretch = true
            }
        }
    }

    @IBAction func cancelProgressBarButtonClicked(_ sender: UIButton) {
        MBProgressHUD.hide(for: self.view, animated: true)
        print("Progress cancel button clicked")
    }

    func showAlertViewMessage(message: String, title: String, showDetails: Bool? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}

