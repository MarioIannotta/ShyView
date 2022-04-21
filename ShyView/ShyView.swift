//
//  ShyView.swift
//  ShyView
//
//  Created by Mario Iannotta on 21/04/22.
//

import UIKit

public class ShyView: UIView {

    lazy var hiddenView: UIView? = {
        let hiddenView: UIView
        let textField = UITextField()
        textField.isSecureTextEntry = true
        hiddenView = textField.layer.sublayers?.first?.delegate as! UIView
        hiddenView.subviews.forEach { $0.removeFromSuperview() }
        hiddenView.isUserInteractionEnabled = true
        return hiddenView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init?(_ subview: UIView) {
        super.init(frame: .zero)
        let textField = UITextField()
        textField.isSecureTextEntry = true
        guard let hiddenView = textField.layer.sublayers?.first?.delegate as? UIView
        else {
            print("Something doesn't work, please fill an issue with your OS and device version.")
            return nil
        }
        hiddenView.subviews.forEach { $0.removeFromSuperview() }
        hiddenView.isUserInteractionEnabled = true
        backgroundColor = .clear
        hiddenView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hiddenView)
        NSLayoutConstraint.activate([
            hiddenView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hiddenView.trailingAnchor.constraint(equalTo: trailingAnchor),
            hiddenView.bottomAnchor.constraint(equalTo: bottomAnchor),
            hiddenView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        hiddenView.addSubview(subview)
        NSLayoutConstraint.activate([
            hiddenView.leadingAnchor.constraint(equalTo: subview.leadingAnchor),
            hiddenView.trailingAnchor.constraint(equalTo: subview.trailingAnchor),
            hiddenView.bottomAnchor.constraint(equalTo: subview.bottomAnchor),
            hiddenView.topAnchor.constraint(equalTo: subview.topAnchor)
        ])
    }
}
