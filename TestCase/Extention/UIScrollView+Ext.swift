//
//  UIScrollView+Ext.swift
//  TestCase
//
//  Created by Rafli on 10/08/23.
//

import Foundation
import UIKit

extension UIScrollView {
    
    func addRefreshControl(action: @escaping () -> Void) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshAction(sender:)), for: .valueChanged)
        objc_setAssociatedObject(self, &AssociatedKeys.refreshControlAction, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.refreshControl = refreshControl
    }
    
    private struct AssociatedKeys {
        static var refreshControlAction = "refreshControlAction"
    }
    
    @objc private func handleRefreshAction(sender: UIRefreshControl) {
        if let action = objc_getAssociatedObject(self, &AssociatedKeys.refreshControlAction) as? () -> Void {
            action()
        }
    }
    
    func isRefresing() -> Bool {
        if let refreshControl = refreshControl {
            return refreshControl.isRefreshing
        }
        
        return false
    }
    
    func endRefreshing() {
        refreshControl?.endRefreshing()
    }
}
