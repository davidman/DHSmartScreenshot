import Foundation
import UIKit

extension UIImage {
 
    class func imageWithColor(color:UIColor, size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen().scale)
        let context = UIGraphicsGetCurrentContext()
        if context == nil {
            return nil
        }
        color.set()
        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIImage {
    
    class func verticalAppendedTotalImageSizeFromImagesArray(imagesArray:[UIImage]) -> CGSize {
        var totalSize = CGSizeZero
        for im in imagesArray {
            let imSize = im.size
            totalSize.height += imSize.height
            totalSize.width = max(totalSize.width, imSize.width)
        }
        return totalSize
    }

    
    class func verticalImageFromArray(imagesArray:[UIImage]) -> UIImage? {
       
        var unifiedImage:UIImage?
        var totalImageSize = self.verticalAppendedTotalImageSizeFromImagesArray(imagesArray)
        
        UIGraphicsBeginImageContextWithOptions(totalImageSize,false, 0)

        var imageOffsetFactor:CGFloat = 0
        
        for img in imagesArray {
            img.drawAtPoint(CGPointMake(0, imageOffsetFactor))
            imageOffsetFactor += img.size.height;
        }
        unifiedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return unifiedImage
    }
}
