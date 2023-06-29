#if os(iOS)
import UIKit

extension UIColor {
    static func backgroundPattern(
        backgroundColor: UIColor = .white,
        patternColor: UIColor = .systemPink.withAlphaComponent(0.1),
        cornerRadius: CGFloat? = nil,
        size: CGSize = .init(width: 36, height: 36),
        inset: CGFloat? = nil
    ) -> UIColor {
        let inset = inset ?? min(size.width, size.height) / 12
        let cornerRadius = cornerRadius ?? inset * 2
        let imageRenderer = UIGraphicsImageRenderer(size: size)
        
        let image = imageRenderer.image { ctx in
            
            ctx.cgContext.setFillColor(backgroundColor.cgColor)
            ctx.cgContext.addRect(.init(origin: .zero, size: size))
            ctx.cgContext.fillPath()
            
            let tilePath = UIBezierPath(
                roundedRect: .init(
                    origin: .init(
                        x: inset,
                        y: inset
                    ),
                    size: .init(
                        width: size.width - inset * 2,
                        height: size.height - inset * 2
                    )
                ),
                cornerRadius: cornerRadius
            )
            
            ctx.cgContext.setFillColor(patternColor.cgColor)
            ctx.cgContext.addPath(tilePath.cgPath)
            ctx.cgContext.fillPath()
        }
        
        return UIColor(patternImage: image)
    }
}
#endif
