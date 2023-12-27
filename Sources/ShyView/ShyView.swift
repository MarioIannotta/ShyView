#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import UIKit

public protocol ShyViewProvider: UIView {}
extension UIView: ShyViewProvider {}

extension ShyViewProvider {
    /// Wraps a view in ``ShyView``
    ///
    /// - Parameters:
    ///   - isSensitive: Default value for `ShyView.isPrivacySensitive` property
    public func privacySensitive(_ isSensitive: Bool = true) -> ShyView<Self> {
        ShyView(wrappedValue: self, isPrivacySensitive: isSensitive)
    }
}

@propertyWrapper
public class ShyView<Content: UIView>: UIView {
    private let secureContainer: SecureContainerView = .init()
    
    /// Indicates if underlying ``SecureContainerView`` is configured properly
    ///
    /// - Returns: `false` if system behavior changed and view cannot be secure `true` otherwise
    public var isConfiguredProperly: Bool {
        secureContainer.isConfiguredProperly
    }


    /// Indicates if  underlying``SecureContainerView`` isPrivacySensitive
    public var isPrivacySensitive: Bool {
        get { secureContainer.isPrivacySensitive }
        set { secureContainer.isPrivacySensitive = newValue }
    }
    
    /// Content view
    public var content: Content = .init() {
        didSet { configureContent() }
    }

    public var wrappedValue: Content {
        get { self.content }
        set { self.content = newValue }
    }
    
    public var projectedValue: ShyView<Content> { self }
    
    public convenience init(
        _ content: Content,
        isPrivacySensitive: Bool = true
    ) {
        self.init(
            wrappedValue: content,
            isPrivacySensitive: isPrivacySensitive
        )
    }
    
    public init(
        wrappedValue: Content = .init(),
        isPrivacySensitive: Bool = true
    ) {
        self.content = wrappedValue
        super.init(frame: .zero)
        self.isPrivacySensitive = isPrivacySensitive
        self.configure()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }

    public override var isUserInteractionEnabled: Bool {
        get { super.isUserInteractionEnabled }
        set {
            super.isUserInteractionEnabled = newValue
            secureContainer.isUserInteractionEnabled = newValue
        }
    }

    private func configure() {
        secureContainer.removeFromSuperview()

        addSubview(secureContainer)
        secureContainer.pinEdgesToSuperview()

        configureContent()
    }

    private func configureContent() {
        content.removeFromSuperview()
        
        secureContainer.contentView.addSubview(content)
        content.pinEdgesToSuperview()
    }
}
#endif
