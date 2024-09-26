//
//  ProvinceViewModel.swift
//  TestCase
//
//  Created by Rafli on 26/09/24.
//

import Foundation


class ProvinceViewModel : BaseViewModel<[Province]> {
    
    //MARK: - Variables
    private let service = RegionService()
    
    
    func fetch() {
        startLoading()
        service.province() { result in
            switch result {
            case .success(let apiResponse):
                self.handleSuccess(apiResponse)
                
            case .failure(let error):
                self.handleFailure(error.localizedDescription)
            }
        }
    }
    
}
