//
//  State.swift
//  TestCase
//
//  Created by Rafli on 22/05/23.
//

import Foundation

enum State<T> {
    case loading
    case success(T?)
    case failure(String)
}


