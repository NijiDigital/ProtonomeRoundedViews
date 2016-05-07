//
//  UIImage+Rounded.swift
//  ProtonomeRoundedViews
//
//  Created by Daniel Clelland on 20/11/15.
//  Copyright © 2015 Daniel Clelland. All rights reserved.
//

import UIKit

// MARK: - Rounded images

public extension UIImage {
    
    public static func roundedImage(withColor color: UIColor, andCornerRadius cornerRadius: CGFloat) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: cornerRadius * 2.0 + 1.0, height: cornerRadius * 2.0 + 1.0)
        let path = CGPathCreateWithRoundedRect(rect, cornerRadius, cornerRadius, nil)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextAddPath(context, path)
        CGContextFillPath(context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image.resizableImageWithCapInsets(UIEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius), resizingMode: .Stretch)
    }
    
}
