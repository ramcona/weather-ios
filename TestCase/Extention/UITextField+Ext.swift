//
//  UITextField+Ext.swift
//  TestCase
//
//  Created by Rafli on 31/05/23.
//

import Foundation
import UIKit

@IBDesignable
extension UITextField {
    @IBInspectable var chevronImage: UIImage? {
        get {
            guard let chevronImageView = self.rightView as? UIImageView else {
                return nil
            }
            return chevronImageView.image
        }
        set {
            if let image = newValue {
                addChevronDown(with: image)
            } else {
                removeChevronDown()
            }
        }
    }
}


extension UITextField {
    func onChanged(_ action: @escaping (String?) -> Void) {
        addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
        associatedAction = action
    }
    
    @objc private func textFieldValueChanged() {
        associatedAction?(text)
    }
    
    private var associatedAction: ((String?) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.associatedAction) as? (String?) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.associatedAction, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private struct AssociatedKeys {
        static var associatedAction = "textChangedAction"
    }
    
    private func addChevronDown(with image: UIImage) {
        let chevronImageView = UIImageView(image: image)
        
        // Set the content mode and frame for the chevron image view
        chevronImageView.contentMode = .center
        chevronImageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: self.frame.height)
        
        // Create a container view to hold the chevron image view
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + 10, height: self.frame.height))
        containerView.addSubview(chevronImageView)
        
        // Set the right view of the text field to the container view
        self.rightView = containerView
        self.rightViewMode = .always
    }
    
    private func removeChevronDown() {
        self.rightView = nil
        self.rightViewMode = .never
    }
    
}

extension UITextField {
    static func swizzleDelegateMethods() {
        let originalSelector = #selector(setter: UITextField.delegate)
        let swizzledSelector = #selector(UITextField.swizzledSetDelegate(_:))
        
        guard
            let originalMethod = class_getInstanceMethod(UITextField.self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(UITextField.self, swizzledSelector)
        else {
            return
        }
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    @objc private dynamic func swizzledSetDelegate(_ delegate: UITextFieldDelegate?) {
        swizzledSetDelegate(delegate)
        
        if delegate is UITextFieldDelegateWrapper == false {
            let wrapper = UITextFieldDelegateWrapper()
            wrapper.originalDelegate = delegate
            swizzledSetDelegate(wrapper)
        }
    }
}

class UITextFieldDelegateWrapper: NSObject, UITextFieldDelegate {
    weak var originalDelegate: UITextFieldDelegate?
    
    var textFieldShouldReturnClosure: ((UITextField) -> Bool)?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let closure = textFieldShouldReturnClosure {
            return closure(textField)
        } else if let originalDelegate = originalDelegate {
            return originalDelegate.textFieldShouldReturn?(textField) ?? true
        }
        return true
    }
    
    // Implement other UITextFieldDelegate methods here if needed
}

@IBDesignable
class PasswordToggleTextField: UITextField {
    @IBInspectable var showPasswordImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var hidePasswordImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    private var passwordToggleButton: UIButton = UIButton(type: .custom)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureToggle()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureToggle()
    }
    
    private func configureToggle() {
        passwordToggleButton.setImage(showPasswordImage, for: .normal)
        passwordToggleButton.frame = CGRect(x: -5, y: 0, width: 20, height: 20)
        passwordToggleButton.contentMode = .scaleAspectFit
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        passwordToggleButton.setImage(showPasswordImage, for: .normal)
        let containerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 15)))
        containerView.addSubview(passwordToggleButton)
        containerView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        rightView = containerView
        rightViewMode = .always
        isSecureTextEntry = true
    }
    
    private func updateView() {
        passwordToggleButton.setImage(isSecureTextEntry ? showPasswordImage : hidePasswordImage, for: .normal)
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        updateView()
    }
}
