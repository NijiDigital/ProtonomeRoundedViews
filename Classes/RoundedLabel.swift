//
//  RoundedLabel.swift
//  ProtonomeRoundedViews
//
//  Created by Daniel Clelland on 1/05/16.
//  Copyright © 2016 Daniel Clelland. All rights reserved.
//

import UIKit

/// IBDesignable `UILabel` subclass with added IBInspectable properties for setting corner radius and fill color. Overrides `drawTextInRect:` to draw the rounded corners in a performant manner.
@IBDesignable public class RoundedLabel: UILabel {
    
    // MARK: - Properties
    
    /// The label's corner radius. The radius given to the rounded rect created in `drawTextInRect:`.
    /// If this is ever set, the label's `backgroundColor` will be updated with `UIColor.clearColor()`.
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            configureView()
        }
    }
    
    /// The label's fill color. The color given to the rounded rect created in `drawTextInRect:`.
    /// If this is ever set, the label's `backgroundColor` will be updated with `UIColor.clearColor()`.
    @IBInspectable public var fillColor: UIColor? {
        didSet {
            configureView()
        }
    }
    
    /// The label's top text inset.
    @IBInspectable public var textInsetTop: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// The label's left text inset.
    @IBInspectable public var textInsetLeft: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// The label's bottom text inset.
    @IBInspectable public var textInsetBottom: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// The label's right text inset.
    @IBInspectable public var textInsetRight: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: - Configuration
    
    private func configureView() {
        backgroundColor = UIColor.clearColor()
        setNeedsDisplay()
    }
    
    // MARK: - Overrides
    
    override public func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let rect = super.textRectForBounds(textInsets.inset(bounds), limitedToNumberOfLines: numberOfLines)
        return textInsets.inverse.inset(rect)
    }
    
    override public func drawTextInRect(rect: CGRect) {
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext()!, (fillColor?.CGColor)!)
        backgroundPath.fill()
        super.drawTextInRect(textInsets.inset(rect))
    }
    
    // MARK: - Private getters

    private var backgroundPath: UIBezierPath {
        return UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
    }
    
    private var textInsets: UIEdgeInsets {
        return UIEdgeInsets(top: textInsetTop, left: textInsetLeft, bottom: textInsetBottom, right: textInsetRight)
    }
    
}

// MARK: - Private extensions

private extension UIEdgeInsets {
    
    var inverse: UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
    
    func inset(rect: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(rect, self)
    }
    
}
