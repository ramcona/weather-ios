//
//  CityViewModel.swift
//  TestCase
//
//  Created by Rafli on 26/09/24.
//

import Foundation

class CityViewModel : BaseViewModel<[City]> {
    
    //MARK: - Variables
    private let service = RegionService()
    
    
    func fetch(provinceId:String) {
        startLoading()
        service.city(provinceId: provinceId) { result in
            switch result {
            case .success(let apiResponse):
                self.handleSuccess(apiResponse)
                
            case .failure(let error):
                self.handleFailure(error.localizedDescription)
            }
        }
    }
    
}
