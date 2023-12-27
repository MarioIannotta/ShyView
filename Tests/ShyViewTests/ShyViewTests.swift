import XCTest
import SnapshotTesting

@testable import ShyView

#if os(iOS)
import UIKit

/// Uses iPhone15 Pro (iOS 17)
class ShyViewTests: XCTestCase {
    func testPrivacySensitive() {
        assertSnapshot(
            matching: InlineTopSecretLabelViewController(isPrivacySensitive: true),
            as: .image(size: .init(width: 216, height: 216))
        )
        assertSnapshot(
            matching: WrapperTopSecretLabelViewController(isPrivacySensitive: true),
            as: .image(size: .init(width: 216, height: 216))
        )
    }

    func testPrivacyInsensitive() {
        assertSnapshot(
            matching: InlineTopSecretLabelViewController(isPrivacySensitive: false),
            as: .image(size: .init(width: 216, height: 216))
        )
        assertSnapshot(
            matching: WrapperTopSecretLabelViewController(isPrivacySensitive: false),
            as: .image(size: .init(width: 216, height: 216))
        )
    }
}

private final class InlineTopSecretLabelViewController: SnapshotViewController {
    override var content: UIView {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8

        let label = UILabel()
        label.text = "The_Password"
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)

        let labelView = label.privacySensitive(isPrivacySensitive)

        contentView.addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, constant: -16),
            labelView.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor, constant: 16)
        ])

        return contentView
    }

    override func configure() {
        super.configure()
        self.view.backgroundColor = .backgroundPattern()
    }
}

private final class WrapperTopSecretLabelViewController: SnapshotViewController {
    @ShyView
    var label: UILabel = .init()

    override var content: UIView {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8

        _label.isPrivacySensitive = isPrivacySensitive
        label.text = "The_Password"
        label.textAlignment = .center

        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)

        contentView.addSubview(_label)
        _label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            _label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            _label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            _label.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, constant: -16),
            _label.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor, constant: 16)
        ])

        return contentView
    }

    override func configure() {
        super.configure()
        self.view.backgroundColor = .backgroundPattern()
    }
}
#endif
