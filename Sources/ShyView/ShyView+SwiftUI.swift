//
//  ShyView+SwiftUI.swift
//  ShyView
//
//  Created by Maxim Krouk on 01/09/2023.
//

#if canImport(SwiftUI) && !os(watchOS) && !os(tvOS)
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    /// Privacy sensitive backport, provided by ShyView
    ///
    /// Uses `SwiftUI.View.privacySensitive` modifier on supported os versions and
    /// `SwiftUI.UIHostingController` wrapped in ``ShyView`` if
    /// `SwiftUI.View.privacySensitive` modifier is not supported
    @ViewBuilder
    public func shyViewPrivacySensitive(_ isSensitive: Bool) -> some View {
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            privacySensitive(isSensitive)
        } else if isSensitive {
            _shyViewPrivacySensitive(isSensitive)
        } else {
            self
        }
    }
    
    /// Makes view privacy sensitive using ShyView
    internal func _shyViewPrivacySensitive(_ isSensitive: Bool) -> some View {
        _ShyViewSwiftUI(self, isPrivacySensitive: isSensitive)
    }
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
fileprivate struct _ShyViewSwiftUI<Content: View>: View {
    typealias HostingController = UIHostingController<Content>
    
    private let content: Content
    
    @State
    private var hostingController: HostingController?
    
    private var isPrivacySensitive: Bool
    
    init(_ content: Content, isPrivacySensitive: Bool) {
        self.content = content
        self.isPrivacySensitive = isPrivacySensitive
    }
    
    var body: some View {
        Representable(
            $hostingController,
            isPrivacySensitive: isPrivacySensitive
        )
        .background(GeometryReader { proxy in
            Color.clear
                .preference(key: _ShyViewSwiftUISizeKey.self, value: proxy.size)
                .onPreferenceChange(_ShyViewSwiftUISizeKey.self) { value in
                    if hostingController == nil {
                        hostingController = .init(rootView: content)
                        hostingController?.view.backgroundColor = .clear
                    }
                    hostingController?.view.frame.size = value
                }
        })
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension _ShyViewSwiftUI {
    fileprivate struct Representable: UIViewRepresentable {
        @Binding
        var hostingController: HostingController?
        
        @ShyView
        var protectedView: UIView
        
        init(
            _ hostingController: Binding<HostingController?>,
            isPrivacySensitive: Bool
        ) {
            self._hostingController = hostingController
            self._protectedView.isPrivacySensitive = isPrivacySensitive
        }
        
        func makeUIView(context: Context) -> ShyView<UIView> {
            if let hostingController {
                self._protectedView.content = hostingController.view
            }
            return _protectedView
        }
        
        func updateUIView(_ view: ShyView<UIView>, context: Context) {}
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
fileprivate struct _ShyViewSwiftUISizeKey: PreferenceKey {
    static var defaultValue: CGSize = .init(width: 500, height: 500)
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
#endif
