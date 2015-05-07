import Foundation
import UIKit

extension UIView {
    func screenshotForCroppingRect(croppingRect:CGRect) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(croppingRect.size, false, UIScreen.mainScreen().scale);

        var context = UIGraphicsGetCurrentContext()
        if context == nil {
            return nil;
        }
        
        CGContextTranslateCTM(context, -croppingRect.origin.x, -croppingRect.origin.y)
        self.layoutIfNeeded()
        self.layer.renderInContext(context)
        
        let screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
    
    var screenshot : UIImage? {
        return self.screenshotForCroppingRect(self.bounds)
    }
}
