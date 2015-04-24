import Foundation
import UIKit

extension UIScrollView {
    
    var screenshotOfVisibleContent : UIImage? {
        var croppingRect = self.bounds
        croppingRect.origin = self.contentOffset
        return self.screenshotForCroppingRect(croppingRect)
    }

}