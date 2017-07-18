# GoogleAPIFileUploading

GoogleAPIFileUploading is an demo project for iOS illustrating how to upload files with the [Google Drive API](https://developers.google.com/drive/ios)

## Overview

GoogleAPIFileUploading is a sample Google Drive app written in Swift for iOS. It is a uploading an image
with the MIME type image/* that are stored in a user's Google Drive

## Prerequisites

To run this sample, you'll need:

* [Xcode 8.0](https://developer.apple.com/xcode/) or greater.
* [CocoaPods](http://cocoapods.org/) dependency manager.
* Access to the internet and a web browser.
* A Google account with Google Drive enabled.


## Building the sample

### Enable the Drive API and Google Sign-in

1. Use [this wizard](https://developers.google.com/mobile/add?platform=ios&cntapi=signin&cnturl=https%3A%2F%2Fconsole.developers.google.com%2Fstart%2Fapi%3Fid%3Ddrive&cntlbl=Enable%20the%20Drive%20API) to create a new app or select an existing one.
1. Enter "com.kahuna.googleAPIFileUploading" into the field iOS Bundle ID and click the Continue button.
1. Click the Google Sign-In icon and then click the Enable Google Sign-in button. Click the Continue button.
1. Click the Download `GoogleService-Info.plist` button to download the configuration file. Take note of where you saved it. Click the Enable the Drive API button.
1. Use the dropdown menu to select the same project you use in the previous wizard and click the Continue button.
1. Close the wizard.

### Fetch and build the app

1. Clone the git repo

        git clone git@github.com:SiddharthChopra/GoogleAPIFileUploading.git
        cd GoogleAPIFileUploading
1. Open `GoogleAPIFileUploading/GoogleAPIFileUploading.xcworkspace` in Xcode
1. Replace `GoogleService-Info.plist` with the file you previously downloaded
1. Add the URL scheme in `Info.plist`  with your reversed client ID.
  2. Open your project configuration: double-click the project name in the left tree view. Select your app from the TARGETS section, then select the Info tab, and expand the URL Types section.
  2. Click the + button, and add a URL scheme for your reversed client ID. To find this value, open the GoogleService-Info.plist configuration file, and look for the REVERSED_CLIENT_ID key. Copy the value of that key, and paste it into the URL Schemes box on the configuration page. Leave the other fields blank.
1. Build the project and run it on the iOS simulator.


## Author

Siddharth Chopra, siddharth5852@gmail.com

## License

GoogleAPIFileUploading is available under the MIT license. See the LICENSE file for more info.
