import Foundation
import UIKit

extension UIImage {
    
    class func imageWithColor(color:UIColor, size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        if context == nil {
            return nil
        }
        color.set()
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIImage {
    
    class func verticalAppendedTotalImageSizeFromImagesArray(imagesArray:[UIImage]) -> CGSize {
        var totalSize = CGSize.zero
        for im in imagesArray {
            let imSize = im.size
            totalSize.height += imSize.height
            totalSize.width = max(totalSize.width, imSize.width)
        }
        return totalSize
    }
    
    
    class func verticalImageFromArray(imagesArray:[UIImage]) -> UIImage? {
        
        var unifiedImage:UIImage?
        let totalImageSize = self.verticalAppendedTotalImageSizeFromImagesArray(imagesArray: imagesArray)
        
        UIGraphicsBeginImageContextWithOptions(totalImageSize,false, 0)
        
        var imageOffsetFactor:CGFloat = 0
        
        for img in imagesArray {
            img.draw(at: CGPoint(x: 0, y: imageOffsetFactor))
            imageOffsetFactor += img.size.height;
        }
        unifiedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return unifiedImage
    }
}
