//
//  BaseViewModel.swift
//  TestCase
//
//  Created by Rafli on 22/05/23.
//

import Foundation

class BaseViewModel<T> {
    var state: State<T>? {
        didSet {
            stateDidChange?(state)
        }
    }
    
    var stateDidChange: ((State<T>?) -> Void)?
    
    func startLoading() {
        state = .loading
    }
    
    func handleSuccess(_ data: T?) {
        state = .success(data)
    }
    
    func handleFailure(_ error: String) {
        state = .failure(error)
    }
}
