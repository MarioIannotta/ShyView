import XCTest
import SnapshotTesting

@testable import ShyView

#if os(iOS)
import UIKit

class ShyViewTests: XCTestCase {
    func testPrivacySensitive() {
        assertSnapshot(
            matching: TopSecretLabelViewController(isPrivacySensitive: true),
            as: .image(size: .init(width: 216, height: 216))
        )
    }
    
    func testPrivacyInsensitive() {
        assertSnapshot(
            matching: TopSecretLabelViewController(isPrivacySensitive: false),
            as: .image(size: .init(width: 216, height: 216))
        )
    }
}

private final class TopSecretLabelViewController: UIViewController {
    let contentView: UIView
    
    init(isPrivacySensitive: Bool) {
        self.contentView = Self.makeLabel(isPrivacySensitive)
        super.init(nibName: nil, bundle: nil)
        
        self.view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.5),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 32)
        ])
        
        self.view.backgroundColor = .backgroundPattern()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Required to take system snapshot since the library uses custom rendering system
        view.snapshotView(afterScreenUpdates: true).map { snapshotView in
            self.view.addSubview(snapshotView)
            NSLayoutConstraint.activate([
                snapshotView.topAnchor.constraint(equalTo: view.topAnchor),
                snapshotView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                snapshotView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                snapshotView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }
    
    private static func makeLabel(_ isPrivacySensitive: Bool) -> UIView {
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
        NSLayoutConstraint.activate([
            labelView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, constant: -16),
            labelView.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor, constant: 16)
        ])
        
        return contentView
    }
}
#endif
