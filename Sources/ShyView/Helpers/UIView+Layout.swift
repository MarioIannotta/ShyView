//
//  UIView+Layout.swift
//  ShyView
//
//  Created by Maxim Krouk on 01/09/2023.
//

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import UIKit

extension UIView {
    func pinEdgesToSuperview() {
        guard let superview else { return }
        pinEdges(to: superview)
    }
    
    func pinEdges(to target: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: target.topAnchor),
            bottomAnchor.constraint(equalTo: target.bottomAnchor),
            leadingAnchor.constraint(equalTo: target.leadingAnchor),
            trailingAnchor.constraint(equalTo: target.trailingAnchor)
        ])
    }
}

#endif
