//
//  MainViewController.swift
//  TestCase
//
//  Created by Rafli on 24/09/24.
//

import UIKit

class MainViewController: BaseViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        
            if self.userDefaultManager.getLoginStatus() {
                Go().moveTo(withSelf: self, withTarget: DashboardViewController())
            }else {
                Go().moveTo(withSelf: self, withTarget: RegisterViewController())
            }
            
        }
        

    }
    
}
