//
//  UIView+SecureView.swift
//  ShyView
//
//  Created by Maxim Krouk on 01/09/2023.
//

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import UIKit

extension UIView {
    static func makeSecureView() -> UIView? {
        let secureView: UIView?
        let textField = UITextField()
        textField.isSecureTextEntry = true
        secureView = textField.layer.sublayers?.first?.delegate as? UIView
        secureView?.subviews.forEach { $0.removeFromSuperview() }
        secureView?.isUserInteractionEnabled = true
        return secureView
    }
}

#endif
