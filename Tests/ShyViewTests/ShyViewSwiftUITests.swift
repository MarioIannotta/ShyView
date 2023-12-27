import XCTest
import SnapshotTesting
@testable import ShyView

#if canImport(SwiftUI)
import SwiftUI

/// Uses iPhone15 Pro (iOS 17)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
class ShyViewSwiftUITests: XCTestCase {
    func testPrivacySensitive() {
        assertSnapshot(
            matching: ShyHostingViewController(isPrivacySensitive: true),
            as: .image(size: .init(width: 216, height: 216))
        )
    }
    
    func testPrivacySensitiveBackport() {
        assertSnapshot(
            matching: BackportShyHostingViewController(isPrivacySensitive: true),
            as: .image(size: .init(width: 216, height: 216))
        )
    }
    
    func testPrivacyInsensitive() {
        assertSnapshot(
            matching: ShyHostingViewController(isPrivacySensitive: false),
            as: .image(size: .init(width: 216, height: 216))
        )
    }
    
    func testPrivacyInsensitiveBackport() {
        assertSnapshot(
            matching: BackportShyHostingViewController(isPrivacySensitive: false),
            as: .image(size: .init(width: 216, height: 216))
        )
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private struct ContentView: View {
    var body: some View {
        Text("The_Password")
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private final class ShyHostingViewController: SnapshotViewController {
    var host: UIViewController!
    
    override var content: UIView {
        host = UIHostingController(
            rootView: ContentView()
                .shyViewPrivacySensitive(isPrivacySensitive)
        )
        
        addChild(host)
        return host.view
    }
    
    override func configure() {
        super.configure()
        host.didMove(toParent: self)
        host.view.backgroundColor = .backgroundPattern()
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private final class BackportShyHostingViewController: SnapshotViewController {
    var host: UIViewController!
    
    override var content: UIView {
        host = UIHostingController(
            rootView: ContentView()
                ._shyViewPrivacySensitive(isPrivacySensitive)
        )
        
        addChild(host)
        return host.view
    }
    
    override func configure() {
        super.configure()
        host.didMove(toParent: self)
        host.view.backgroundColor = .backgroundPattern()
    }
}
#endif
