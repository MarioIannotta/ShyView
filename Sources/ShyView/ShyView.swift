//
//  ShyView.swift
//  ShyView
//
//  Created by Mario Iannotta on 21/04/22.
//

import Foundation

#if os(iOS)
import UIKit

extension UIView {
    public func privacySensitive(_ isSensitive: Bool = true) -> UIView {
        isSensitive ? { ShyView(self) ?? self }() : self
    }
}

public class ShyView: UIView {
    private var secureView: UIView? = {
        let secureView: UIView?
        let textField = UITextField()
        textField.isSecureTextEntry = true
        secureView = textField.layer.sublayers?.first?.delegate as? UIView
        secureView?.subviews.forEach { $0.removeFromSuperview() }
        secureView?.isUserInteractionEnabled = true
        return secureView
    }()
    
    public let contentView = UIView()
    
    /// Indicates if the configuration was successful
    ///
    /// Returns `false` if the behavior of the secureView was changed by Apple and the approach is no longer availabe
    public var isConfiguredProperly: Bool {
        return secureView != nil
    }
    
    public override var isUserInteractionEnabled: Bool {
        get { super.isUserInteractionEnabled }
        set {
            super.isUserInteractionEnabled = newValue
            contentView.isUserInteractionEnabled = newValue
            secureView?.isUserInteractionEnabled = newValue
        }
    }
    
    /// Creates a new Shy view with a protected view set
    ///
    /// Fails if the behavior of the secureView was changed by Apple and the approach is no longer availabe
    public convenience init?(_ protectedView: UIView) {
        self.init(frame: .zero)
        protectedView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(protectedView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: protectedView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: protectedView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: protectedView.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: protectedView.topAnchor)
        ])
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    private func configure() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        if let secureView = secureView {
            secureView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(secureView)
            NSLayoutConstraint.activate([
                secureView.leadingAnchor.constraint(equalTo: leadingAnchor),
                secureView.trailingAnchor.constraint(equalTo: trailingAnchor),
                secureView.bottomAnchor.constraint(equalTo: bottomAnchor),
                secureView.topAnchor.constraint(equalTo: topAnchor)
            ])
            
            contentView.translatesAutoresizingMaskIntoConstraints = false
            secureView.addSubview(contentView)
            NSLayoutConstraint.activate([
                contentView.leadingAnchor.constraint(equalTo: secureView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: secureView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: secureView.bottomAnchor),
                contentView.topAnchor.constraint(equalTo: secureView.topAnchor)
            ])
        } else {
            Self.incompatibilityHandler?.action()
            
            contentView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(contentView)
            NSLayoutConstraint.activate([
                contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
                contentView.topAnchor.constraint(equalTo: topAnchor)
            ])
        }
    }
}

extension ShyView {
    /// Triggered action if the behavior of the secureView was changed by Apple and the approach is no longer availabe
    public static var incompatibilityHandler: IncompatibilityHandler? = .assert()
    
    public struct IncompatibilityHandler {
        public init(_ action: @escaping () -> Void) {
            self.action = action
        }
        
        internal let action: () -> Void
    }
}

extension ShyView.IncompatibilityHandler {
    public static let defaultMessage = """
    Something doesn't work, please fill an issue with your OS and device version.
    Repo url: https://github.com/MarioIannotta/ShyView
    You can disable this message by setting `ShyView.incompatibilityHandler` to `.none`
    """
    
    /// Creates a custom handler for the default message
    public static func defaultMessage(
        _ handler: @escaping (String) -> Void
    ) -> Self {
        return .init { handler(defaultMessage) }
    }
    
    /// Creates custom handler, that prints  error message to standard output
    public static func print(
        _ message: String = defaultMessage
    ) -> Self {
        return .init { Swift.print(message) }
    }
    
    /// Creates custom handler, that triggers assertion failure with a specified  message
    public static func assert(
        _ message: String = defaultMessage
    ) -> Self {
        return .init { assertionFailure(message) }
    }
}
#endif
