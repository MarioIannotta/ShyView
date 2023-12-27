#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import UIKit
@testable import ShyView

/// Overlays view content with a system snapshot
open class SnapshotViewController: UIViewController {
    let isPrivacySensitive: Bool
    
    public required init(isPrivacySensitive: Bool) {
        self.isPrivacySensitive = isPrivacySensitive
        super.init(nibName: nil, bundle: nil)
        
        self.configure()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) is unavailable, use init(privacySensitive:)")
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Required to take system snapshot since the library uses custom rendering system
        view.snapshotView(afterScreenUpdates: true).map { snapshotView in
            let snapshot = UIImageView(
                image: UIGraphicsImageRenderer(bounds: snapshotView.bounds)
                    .image {
                        snapshotView.layer.draw(in: $0.cgContext)
                        $0.cgContext.addEllipse(in: CGRect(origin: .init(x: 50, y: 50), size: .init(width: 16, height: 16)))
                        $0.cgContext.setFillColor(UIColor.systemGreen.cgColor)
                        $0.cgContext.fillPath()
                    }
            )
            
            self.view.addSubview(snapshot)
            snapshot.pinEdgesToSuperview()
        }
    }
    
    open var content: UIView {
        fatalError("Not implemented")
    }
    
    open func configure() {
        let contentView = content
        self.view.addSubview(contentView)
        contentView.pinEdgesToSuperview()
    }
}
#endif
