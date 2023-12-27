//
//  ShyView.swift
//  ShyView
//
//  Created by Mario Iannotta on 21/04/22.
//

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import UIKit

public class SecureContainerView: UIView {
    private var secureView: UIView? = .makeSecureView()

    public let contentView = UIView()
    
    public var isPrivacySensitive: Bool {
        get { secureView?.superview == self }
        set { configure(isPrivacySensitive: newValue) }
    }
    
    /// Indicates if the configuration was successful
    ///
    /// - Returns: `false` if the behavior of the secureView was changed by Apple and the approach is no longer availabe
    public var isConfiguredProperly: Bool {
        return secureView != nil
    }
    
    public override var isUserInteractionEnabled: Bool {
        get { super.isUserInteractionEnabled }
        set {
            super.isUserInteractionEnabled = newValue
            secureView?.isUserInteractionEnabled = newValue
            contentView.isUserInteractionEnabled = newValue
        }
    }
    
    /// Creates a new ``SecureContainerView`` with a protected view set
    public convenience init(_ protectedView: UIView) {
        self.init(frame: .zero)
        contentView.addSubview(protectedView)
        protectedView.pinEdgesToSuperview()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureBackground()
        self.configure(isPrivacySensitive: true)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureBackground()
        self.configure(isPrivacySensitive: true)
    }

    private func configureBackground() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }

    private func configure(isPrivacySensitive: Bool) {
        guard let secureView = secureView else {
            Self.incompatibilityHandler?.action()
            
            addSubview(contentView)
            contentView.pinEdgesToSuperview()
            return
        }
        
        secureView.removeFromSuperview()
        contentView.removeFromSuperview()
        
        if isPrivacySensitive {
            addSubview(secureView)
            secureView.pinEdgesToSuperview()
            
            secureView.addSubview(contentView)
            contentView.pinEdgesToSuperview()
        } else {
            addSubview(contentView)
            contentView.pinEdgesToSuperview()
        }
    }
}

extension SecureContainerView {
    /// Triggered action if the behavior of the secureView was changed by Apple and the approach is no longer availabe
    public static var incompatibilityHandler: IncompatibilityHandler? = .runtimeWarning()
    
    public struct IncompatibilityHandler {
        public init(_ action: @escaping () -> Void) {
            self.action = action
        }
        
        internal let action: () -> Void
    }
}

extension SecureContainerView.IncompatibilityHandler {
    public static let defaultMessage = """
    Something doesn't work, please fill an issue with your OS and device version.
    Repo url: https://github.com/MarioIannotta/ShyView
    You can disable this message by setting `ShyView.incompatibilityHandler` to `.none`
    """
    
    /// Creates a custom action handler for the default message
    public static func defaultMessage(
        _ handler: @escaping (String) -> Void
    ) -> Self {
        return .init { handler(defaultMessage) }
    }
    
    /// Creates custom handler, that prints error message to standard output
    public static func print(
        _ message: String = defaultMessage
    ) -> Self {
        return .init { Swift.print(message) }
    }
    
    /// Creates custom handler, that triggers assertion failure with a specified message
    public static func assert(
        _ message: String = defaultMessage
    ) -> Self {
        return .init { assertionFailure(message) }
    }
    
    /// Creates custom handler, that triggers runtime warning with a specified message
    public static func runtimeWarning(
        _ message: String = defaultMessage
    ) -> Self {
        return .init { runtimeWarn(message) }
    }
}
#endif
