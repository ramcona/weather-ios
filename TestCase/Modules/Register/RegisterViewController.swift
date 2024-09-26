//
//  RegisterViewController.swift
//  TestCase
//
//  Created by Rafli on 24/09/24.
//

import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet weak var buttonEnter: UIButton!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelProvince: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    
    //VARIABLES
    private var selectedProvince:Province? = nil
    private var selectedCity:City? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        actionView()
        checkValidation()
    }

    @IBAction func buttonEnterTapped(_ sender: Any) {
        let name = textFieldName.text ?? ""

        
        let user = User(name: name, province: selectedProvince, city: selectedCity)
        userDefaultManager.setUser(user)
        userDefaultManager.setLoginStatus(true)
        
        Go().moveTo(withSelf: self, withTarget: DashboardViewController(), clearPrevious: true)
    }
    
    private func actionView() {
        
        labelProvince.addTapGesture {
            let vc = SheetProvinceViewController()
            vc.completionHandler = { data in
                self.selectedProvince = data
                self.labelProvince.text = data.name
                                
                self.selectedCity = nil
                self.labelCity.text = "Pilih Kota"
                
                self.checkValidation()
            }
            
            self.presentDialog(withController: vc)
        }
        
        labelCity.addTapGesture {
            if let selectedProvince = self.selectedProvince {
                let vc = SheetCityViewController()
                vc.provinceId = selectedProvince.id
                vc.completionHandler = { data in
                                    
                    self.selectedCity = data
                    self.labelCity.text = data.name
                    
                    self.checkValidation()
                }
                
                self.presentDialog(withController: vc)
            }else {
                self.showErrorAlert(message: "Pilih provinsi terlebih dahulu")
            }
        }
        
        textFieldName.onChanged { data in
            self.checkValidation()
        }
    }
    
    private func checkValidation() {
        buttonEnter.isEnabled = fieldComplete()
    }
    
    private func fieldComplete() -> Bool {
        let name = textFieldName.text ?? ""
        
        if name.isEmpty { return false }
        
        if selectedProvince == nil {  return false }
        
        if selectedCity == nil {  return false }
        
        
        return true
    }
    
    
    
}
