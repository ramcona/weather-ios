//
//  CustomizedTabBar.swift
//  TestCase
//
//  Created by Rafli on 30/07/23.
//

import UIKit

@IBDesignable
class CustomizedTabBar: UITabBar {
    
    // MARK:- Variables -
    @objc public var centerButtonActionHandler: ()-> () = {}
    
    @IBInspectable public var centerButton: UIButton?
    @IBInspectable public var centerButtonColor: UIColor?
    @IBInspectable public var centerButtonHeight: CGFloat = 50.0
    @IBInspectable public var padding: CGFloat = 5.0
    @IBInspectable public var buttonImage: UIImage?
    @IBInspectable public var buttonTitle: String?
    
    @IBInspectable public var tabbarColor: UIColor = ColorConstants.primaryColor
    @IBInspectable public var unselectedItemColor: UIColor = .init(red: 0.58, green: 0.61, blue: 0.66, alpha: 1.0)
    @IBInspectable public var selectedItemColor: UIColor = UIColor.black
    
    public var arc: Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    private var shapeLayer: CALayer?
    
    private func addShape() {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        
        
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = #colorLiteral(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        shapeLayer.lineWidth = 1.0
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        
        self.shapeLayer = shapeLayer
        self.tintColor = centerButtonColor
        self.unselectedItemTintColor = unselectedItemColor
        self.tintColor = selectedItemColor
        self.setupMiddleButton()
    }
    
    
    override func layoutSubviews() {
           super.layoutSubviews()
           if centerButton == nil {
               self.addShape()
               self.setupMiddleButton()
           }
       }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
    
    func createPath() -> CGPath {
        
        let padding: CGFloat = 5.0
        let centerButtonHeight: CGFloat = 53.0
        
        let f = CGFloat(centerButtonHeight / 2.0) + padding
        let h = frame.height
        let w = frame.width
        let halfW = frame.width/2.0
        let r = CGFloat(18)
        let path = UIBezierPath()
        path.move(to: .zero)
        
        if (!arc) {
            
            path.addLine(to: CGPoint(x: halfW-f-(r/2.0), y: 0))
            
            path.addQuadCurve(to: CGPoint(x: halfW-f, y: (r/2.0)), controlPoint: CGPoint(x: halfW-f, y: 0))
            
            path.addArc(withCenter: CGPoint(x: halfW, y: (r/2.0)), radius: f, startAngle: .pi, endAngle: 0, clockwise: false)
            
            path.addQuadCurve(to: CGPoint(x: halfW+f+(r/2.0), y: 0), controlPoint: CGPoint(x: halfW+f, y: 0))
        }
        path.addLine(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h))
        path.addLine(to: CGPoint(x: 0.0, y: h))
        path.close()
        
        return path.cgPath
    }
    
    private func setupMiddleButton() {
        centerButton = UIButton(frame: CGRect(x: (self.bounds.width / 2) - (centerButtonHeight / 2), y: -16, width: centerButtonHeight, height: centerButtonHeight))
        centerButton!.setNeedsDisplay()
        centerButton!.borderColor = ColorConstants.primaryColor
        centerButton!.borderWidth = 0.1
        centerButton!.layer.cornerRadius = centerButton!.frame.size.width / 2.0
        centerButton!.setImage(UIImage(named: "ic_menu_jactivity"), for: .normal) // Replace "your_image_name_here" with your actual image name
        centerButton!.backgroundColor = .white
        centerButton!.tintColor = ColorConstants.primaryColor
        
        self.centerButton!.isHidden = true
        
        if (!self.arc) {
            DispatchQueue.main.async {
                UIView.transition(with: self.centerButton!, duration: 1,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.centerButton!.isHidden = false
                })
            }
        }
        
        // Add to the tab bar and add click event
        self.addSubview(centerButton!)
        centerButton!.addTarget(self, action: #selector(self.centerButtonAction), for: .touchUpInside)
    }
    
    
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let buttonRadius: CGFloat = 35
        return abs(self.center.x - point.x) > buttonRadius || abs(point.y) > buttonRadius
    }
    
    func createPathCircle() -> CGPath {
        
        let radius: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - radius * 2), y: 0))
        path.addArc(withCenter: CGPoint(x: centerWidth, y: 0), radius: radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: false)
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }
    
    // Menu Button Touch Action
    @objc func centerButtonAction(sender: UIButton) {
        self.centerButtonActionHandler()
    }
    
}

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}
