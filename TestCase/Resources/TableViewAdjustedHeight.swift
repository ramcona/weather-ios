//
//  TableViewAdjustedHeight.swift
//  TestCase
//
//  Created by Rafli on 08/06/23.
//  Copyright © 2023 CAN Craetive. All rights reserved.
//

import Foundation
import UIKit

class TableViewAdjustedHeight: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
