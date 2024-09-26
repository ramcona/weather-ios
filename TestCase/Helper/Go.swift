//
//  Go.swift
//  TestCase
//
//  Created by Rafli on 26/05/23.
//

import Foundation
import UIKit

class Go {
    
    func moveTo(withSelf self:UIViewController,withTarget target:UIViewController, clearPrevious:Bool = false){
        if self.navigationController != nil {
            self.navigationController?.pushViewController(target, animated: true)
            
            if clearPrevious {
                // Clear previous view controllers
                self.navigationController?.viewControllers = [target]
            }

        }else{
            self.present(target, animated: true, completion: nil)
        }
    }
    
    
    
    func move(withSelf self:UIViewController,withTargetName name:String, clearPrevious:Bool = false) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: name))!
        
        if self.navigationController != nil {
            self.navigationController?.pushViewController(vc, animated: true)
            
            if clearPrevious {
                // Clear previous view controllers
                self.navigationController?.viewControllers = [vc]
            }

            
        }else {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    func move(withSelf self:UIViewController,withTargetName targetName:String,withStoryBoard story:String, clearPrevious:Bool = false){
        let storyBoard = UIStoryboard(name: story, bundle: nil)
        let vc = (storyBoard.instantiateViewController(withIdentifier: targetName))
        
        if self.navigationController != nil {
            self.navigationController?.pushViewController(vc, animated: true)
            if clearPrevious {
                // Clear previous view controllers
                self.navigationController?.viewControllers = [vc]
            }
            
        }else {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}
