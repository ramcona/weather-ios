//
//  CurrentWeatherViewModel.swift
//  TestCase
//
//  Created by Rafli on 26/09/24.
//

import Foundation

class CurrentWeatherViewModel : BaseViewModel<WeatherResponse> {
    
    //MARK: - Variables
    private let service = WeatherService()
    
    
    func fetch(cityName:String) {
        startLoading()
        
        service.current(cityName: cityName) { result in
            switch result {
            case .success(let apiResponse):
                
                self.handleSuccess(apiResponse)
                
            case .failure(let error):
                self.handleFailure(error.localizedDescription)
            }
        }
    }
    
}
