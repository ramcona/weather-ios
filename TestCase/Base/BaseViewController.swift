//
//  BaseViewController.swift
//
//  Created by Rafli on 22/05/23.
//

import Foundation
import UIKit
import MaterialComponents



class BaseViewController: UIViewController {
    
    let userDefaultManager = UserDefaultsManager()
    var user:User? = nil
    var shareButtonAction : (()-> Void)?
    private var textFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITextField.swizzleDelegateMethods()
        
        if let user = userDefaultManager.getUser() {
            self.user = user
        }
        
        // Enable interactive pop gesture recognizer
        if navigationController?.viewControllers.count ?? 0 > 1 {
            navigationController?.interactivePopGestureRecognizer?.delegate = self
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        } else {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        //notification center
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func registerTextFields(_ textFields: [UITextField]) {
        self.textFields = textFields
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        let bottomInset = view.safeAreaInsets.bottom
        
        let visibleHeight = view.frame.height - keyboardHeight - bottomInset
        var maxY: CGFloat = 0.0
        
        for textField in textFields {
            let textFieldMaxY = textField.frame.maxY
            if textFieldMaxY > maxY {
                maxY = textFieldMaxY
            }
        }
        
        if maxY > visibleHeight {
            let offsetY = maxY - visibleHeight
            UIView.animate(withDuration: 0.3) {
                self.view.transform = CGAffineTransform(translationX: 0, y: -offsetY)
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeBackButtonToNavifationBar()
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func printDebug(_ message: String) {
        DebugUtils.printDebug(message)
    }
    
    func showErrorAlert(message: String) {
        // Display an alert with the error message
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showMessageAlert(title:String, message: String, finish:Bool = false) {
        // Display an alert with the error message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if finish {
            let okAction = UIAlertAction(title: "Tutup", style: .default, handler: {_ in
                if let navigationController = self.navigationController {
                    navigationController.popViewController(animated: true)
                }
            })
            alert.addAction(okAction)
        }else {
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func showLoadingView() {
        let spinnerView = UIView.init(frame: view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        spinnerView.tag = 110
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
        
    }
    
    func removeLoadingView() {
        DispatchQueue.main.async {
            if let viewWithTag = self.view.viewWithTag(110) {
                viewWithTag.removeFromSuperview()
            }
        }
    }
    
    func removeBackButtonToNavifationBar() {
        if let isHidden = navigationController?.isNavigationBarHidden, !isHidden {
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    func addBackButtonToNavigationBar(isWhite:Bool = false, showMenu:Bool = false, title:String = "", showShare : Bool = false, dynamicAction: Selector? = nil) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        //back button
        let backButtonImage: UIImage?
        if isWhite {
            backButtonImage = UIImage(systemName: "chevron.left")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        } else {
            backButtonImage = UIImage(systemName: "chevron.left")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        }
        
        
        if let dynamicAction = dynamicAction {
            let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: dynamicAction)
            navigationItem.leftBarButtonItem = backButton
        }else {
            let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
            navigationItem.leftBarButtonItem = backButton
        }
        
        //logo app
        //        let logoImage: UIImage?
        //        if isWhite {
        //            logoImage = UIImage(named: "ic_app_logo")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        //        } else {
        //            logoImage = UIImage(named: "ic_app_logo")
        //        }
        //
        //        let logoImageView = UIImageView(image: logoImage)
        //        logoImageView.contentMode = .scaleAspectFit
        //
        //        let logoContainerView = UIView()
        //        logoContainerView.addSubview(logoImageView)
        //
        //        // Add padding constraints to the logoImageView
        //        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        //        logoImageView.leadingAnchor.constraint(equalTo: logoContainerView.leadingAnchor, constant: 5).isActive = true
        //        logoImageView.trailingAnchor.constraint(equalTo: logoContainerView.trailingAnchor, constant: -5).isActive = true
        //        logoImageView.topAnchor.constraint(equalTo: logoContainerView.topAnchor, constant: 5).isActive = true
        //        logoImageView.bottomAnchor.constraint(equalTo: logoContainerView.bottomAnchor, constant: -5).isActive = true
        //
        //        navigationItem.titleView = logoContainerView
        
        // Title label
        let titleLabel = UILabel()
        titleLabel.text = title // Set the title of your page here
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold) // You can customize the font and other properties
        titleLabel.textColor = isWhite ? .white : .black
        navigationItem.titleView = titleLabel
        
        
        //right menu
        if showMenu {
            let notificationImage: UIImage?
            if isWhite {
                notificationImage = UIImage(named: "ic_notification_black")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            } else {
                notificationImage = UIImage(named: "ic_notification_black")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            }
            
            let settingImage: UIImage?
            if isWhite {
                settingImage = UIImage(named: "ic_setting_black")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            } else {
                settingImage = UIImage(named: "ic_setting_black")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            }
            
            let notificationButton = UIBarButtonItem(image: notificationImage, style: .plain, target: self, action: #selector(notificationButtonTapped))
            let settingsButton = UIBarButtonItem(image: settingImage, style: .plain, target: self, action: #selector(settingsButtonTapped))
            navigationItem.rightBarButtonItems = [notificationButton, settingsButton]
        }
        
        if showShare {
            
            let shareImage: UIImage?
            if isWhite {
                shareImage = UIImage(named: "ic_share_white")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            } else {
                shareImage = UIImage(named: "ic_share_white")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            }
            
            let shareButton = UIBarButtonItem(image: shareImage, style: .plain, target: self, action: #selector(shareButtonTapped))
            
            navigationItem.rightBarButtonItems = [shareButton]
            
            
        }
        
        
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func notificationButtonTapped() {
        // Handle notification button tapped event
    }
    
    @objc private func settingsButtonTapped() {
        // Handle settings button tapped event
    }
    
    
    @objc private func shareButtonTapped() {
        // Handle settings button tapped event
        if shareButtonAction != nil{
            shareButtonAction!()
        }
    }
    
    func presentDialog(withController vc: UIViewController) {
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        bottomSheet.preferredContentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        present(bottomSheet, animated: true, completion: nil)
    }
    
    func presentDialog(withController vc: UIViewController, customHeight:Double) {
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        bottomSheet.preferredContentSize = CGSize(width: self.view.frame.size.width, height: customHeight)
        
        present(bottomSheet, animated: true, completion: nil)
    }
    
    func presentSheet(withController vc: UIViewController) {
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        
        present(bottomSheet, animated: true, completion: nil)
    }
    
    func currentDate() -> String {
        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter3.string(from: today)
    }
    
    func createLogDescription(createName: String?, createDate: String, updateName: String?, updateDate: String) -> String {
        if let createName = createName, let updateName = updateName, !createName.isEmpty, !updateName.isEmpty {
            return "Dibuat oleh \(createName ) pada \(createDate) \nDiperbarui oleh \(updateName) pada tanggal \(updateDate)"
        } else {
            let dan = "Dan"
            
            let messageCreate: String
            if let createName = createName, !createName.isEmpty {
                messageCreate = "Dibuat oleh \(createName) pada \(createDate)"
            } else {
                messageCreate = "Dibuat pada \(createDate)"
            }
            
            let messageUpdate: String
            if let updateName = updateName, !updateName.isEmpty {
                messageUpdate = "Diperbarui oleh \(updateName) pada \(updateDate)"
            } else {
                messageUpdate = "Diperbarui pada \(updateDate)"
            }
            
            return "\(messageCreate)\n\(messageUpdate)"
        }
    }
    
    func downloadPDF(from url: URL, filename:String, completion: @escaping (URL?, Error?) -> Void) {
        let session = URLSession.shared
        let task = session.downloadTask(with: url) { location, response, error in
            guard let location = location, error == nil else {
                completion(nil, error)
                return
            }
            
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationURL = documentsDirectory.appendingPathComponent(filename)
            
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                // File already exists, open it directly
                print("PDF already downloaded: \(destinationURL)")
                completion(destinationURL, nil)
            } else {
                // File doesn't exist, move it and then open it
                do {
                    try FileManager.default.moveItem(at: location, to: destinationURL)
                    print("Downloaded PDF to: \(destinationURL)")
                    completion(destinationURL, nil)
                } catch {
                    completion(nil, error)
                }
            }
            
//            do {
//                try FileManager.default.moveItem(at: location, to: destinationURL)
//                completion(destinationURL, nil)
//            } catch {
//                completion(nil, error)
//            }
        }
        
        task.resume()
    }
    
    
}

extension BaseViewController: UIGestureRecognizerDelegate {
    // Implement the following method to allow the interactive pop gesture recognizer to work alongside other gesture recognizers in your view controller.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
