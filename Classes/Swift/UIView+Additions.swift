import Foundation
import UIKit

extension UIView {
    func screenshotForCroppingRect(croppingRect:CGRect) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(croppingRect.size, false, UIScreen.main.scale);
        
        let context = UIGraphicsGetCurrentContext()
        if context == nil {
            return nil;
        }
        
        context!.translateBy(x: -croppingRect.origin.x, y: -croppingRect.origin.y)
        self.layoutIfNeeded()
        self.layer.render(in: context!)
        
        let screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
    
    var screenshot : UIImage? {
        return self.screenshotForCroppingRect(croppingRect: self.bounds)
    }
}
