import Foundation
import UIKit

extension UITableView {
    
    override var screenshot : UIImage? {
        return self.screenshotExcludingHeadersAtSections(excludedHeaderSections: nil, excludingFootersAtSections:nil, excludingRowsAtIndexPaths:nil)
    }
    
    func screenshotOfCellAtIndexPath(indexPath:NSIndexPath) -> UIImage? {
        var cellScreenshot:UIImage?
        
        let currTableViewOffset = self.contentOffset
        
        self.scrollToRow(at: indexPath as IndexPath, at: .top, animated: false)
        
        cellScreenshot = self.cellForRow(at: indexPath as IndexPath)?.screenshot
        
        self.setContentOffset(currTableViewOffset, animated: false)
        
        return cellScreenshot;
    }
    
    var screenshotOfHeaderView : UIImage? {
        let originalOffset = self.contentOffset
        if let headerRect = self.tableHeaderView?.frame {
            self.scrollRectToVisible(headerRect, animated: false)
            let headerScreenshot = self.screenshotForCroppingRect(croppingRect: headerRect)
            self.setContentOffset(originalOffset, animated: false)
            
            return headerScreenshot;
        }
        return nil
    }
    
    var screenshotOfFooterView : UIImage? {
        let originalOffset = self.contentOffset
        if let footerRect = self.tableFooterView?.frame {
            self.scrollRectToVisible(footerRect, animated: false)
            let footerScreenshot = self.screenshotForCroppingRect(croppingRect: footerRect)
            self.setContentOffset(originalOffset, animated: false)
            
            return footerScreenshot;
        }
        return nil
    }
    
    func screenshotOfHeaderViewAtSection(section:Int) -> UIImage? {
        let originalOffset = self.contentOffset
        let headerRect = self.rectForHeader(inSection: section)
        
        self.scrollRectToVisible(headerRect, animated: false)
        let headerScreenshot = self.screenshotForCroppingRect(croppingRect: headerRect)
        self.setContentOffset(originalOffset, animated: false)
        
        return headerScreenshot;
    }
    
    func screenshotOfFooterViewAtSection(section:Int) -> UIImage? {
        let originalOffset = self.contentOffset
        let footerRect = self.rectForFooter(inSection: section)
        
        self.scrollRectToVisible(footerRect, animated: false)
        let footerScreenshot = self.screenshotForCroppingRect(croppingRect: footerRect)
        self.setContentOffset(originalOffset, animated: false)
        
        return footerScreenshot;
    }
    
    
    func screenshotExcludingAllHeaders(withoutHeaders:Bool, excludingAllFooters:Bool, excludingAllRows:Bool) -> UIImage? {
        
        var excludedHeadersOrFootersSections:[Int]?
        
        if withoutHeaders || excludingAllFooters {
            excludedHeadersOrFootersSections = self.allSectionsIndexes
        }
        
        var excludedRows:[NSIndexPath]?
        
        if excludingAllRows {
            excludedRows = self.allRowsIndexPaths
        }
        
        return self.screenshotExcludingHeadersAtSections( excludedHeaderSections: withoutHeaders ? NSSet(array: excludedHeadersOrFootersSections!) : nil,
                                                          excludingFootersAtSections:excludingAllFooters ? NSSet(array:excludedHeadersOrFootersSections!) : nil, excludingRowsAtIndexPaths:excludingAllRows ? NSSet(array:excludedRows!) : nil)
    }
    
    func screenshotExcludingHeadersAtSections(excludedHeaderSections:NSSet?, excludingFootersAtSections:NSSet?,
                                              excludingRowsAtIndexPaths:NSSet?) -> UIImage? {
        var screenshots = [UIImage]()
        
        if let headerScreenshot = self.screenshotOfHeaderView {
            screenshots.append(headerScreenshot)
        }
        
        for section in 0..<self.numberOfSections {
            if let headerScreenshot = self.screenshotOfHeaderViewAtSection(section: section, excludedHeaderSections: excludedHeaderSections) {
                screenshots.append(headerScreenshot)
            }
            
            for row in 0..<self.numberOfRows(inSection: section) {
                let cellIndexPath = NSIndexPath(row: row, section: section)
                if let cellScreenshot = self.screenshotOfCellAtIndexPath(indexPath: cellIndexPath) {
                    screenshots.append(cellScreenshot)
                }
                
            }
            
            if let footerScreenshot = self.screenshotOfFooterViewAtSection(section: section, excludedFooterSections:excludingFootersAtSections) {
                screenshots.append(footerScreenshot)
            }
        }
        
        
        if let footerScreenshot = self.screenshotOfFooterView {
            screenshots.append(footerScreenshot)
        }
        
        return UIImage.verticalImageFromArray(imagesArray: screenshots)
        
    }
    
    func screenshotOfHeadersAtSections(includedHeaderSection:NSSet, footersAtSections:NSSet?, rowsAtIndexPaths:NSSet?) -> UIImage? {
        var screenshots = [UIImage]()
        
        for section in 0..<self.numberOfSections {
            if let headerScreenshot = self.screenshotOfHeaderViewAtSection(section: section, includedHeaderSections: includedHeaderSection) {
                screenshots.append(headerScreenshot)
            }
            
            for row in 0..<self.numberOfRows(inSection: section) {
                if let cellScreenshot = self.screenshotOfCellAtIndexPath(indexPath: NSIndexPath(row: row, section: section), includedIndexPaths: rowsAtIndexPaths) {
                    screenshots.append(cellScreenshot)
                }
            }
            
            if let footerScreenshot = self.screenshotOfFooterViewAtSection(section: section, includedFooterSections: footersAtSections) {
                screenshots.append(footerScreenshot)
            }
        }
        
        return UIImage.verticalImageFromArray(imagesArray: screenshots)
    }
    
    func screenshotOfCellAtIndexPath(indexPath:NSIndexPath, excludedIndexPaths:NSSet?) -> UIImage? {
        if excludedIndexPaths == nil || !excludedIndexPaths!.contains(indexPath) {
            return nil
        }
        return self.screenshotOfCellAtIndexPath(indexPath: indexPath)
    }
    
    func screenshotOfHeaderViewAtSection(section:Int, excludedHeaderSections:NSSet?) -> UIImage? {
        if excludedHeaderSections != nil && !excludedHeaderSections!.contains(section) {
            return nil
        }
        
        var sectionScreenshot = self.screenshotOfHeaderViewAtSection(section: section)
        if sectionScreenshot == nil {
            sectionScreenshot = self.blankScreenshotOfHeaderAtSection(section: section)
        }
        return sectionScreenshot;
    }
    
    func screenshotOfFooterViewAtSection(section:Int, excludedFooterSections:NSSet?) -> UIImage? {
        if excludedFooterSections != nil && !excludedFooterSections!.contains(section) {
            return nil
        }
        
        var sectionScreenshot = self.screenshotOfFooterViewAtSection(section: section)
        if sectionScreenshot == nil {
            sectionScreenshot = self.blankScreenshotOfFooterAtSection(section: section)
        }
        return sectionScreenshot;
    }
    
    func screenshotOfCellAtIndexPath(indexPath:NSIndexPath, includedIndexPaths:NSSet?) -> UIImage? {
        if includedIndexPaths != nil && !includedIndexPaths!.contains(indexPath) {
            return nil
        }
        return self.screenshotOfCellAtIndexPath(indexPath: indexPath)
    }
    
    func screenshotOfHeaderViewAtSection(section:Int, includedHeaderSections:NSSet?) -> UIImage? {
        if includedHeaderSections != nil && !includedHeaderSections!.contains(section) {
            return nil
        }
        
        var sectionScreenshot = self.screenshotOfHeaderViewAtSection(section: section)
        if sectionScreenshot == nil {
            sectionScreenshot = self.blankScreenshotOfHeaderAtSection(section: section)
        }
        return sectionScreenshot;
    }
    
    func screenshotOfFooterViewAtSection(section:Int, includedFooterSections:NSSet?)
        -> UIImage? {
            if includedFooterSections != nil && !includedFooterSections!.contains(section) {
                return nil
            }
            var sectionScreenshot = self.screenshotOfFooterViewAtSection(section: section)
            if sectionScreenshot == nil {
                sectionScreenshot = self.blankScreenshotOfFooterAtSection(section: section)
            }
            return sectionScreenshot;
    }
    
    func blankScreenshotOfHeaderAtSection(section:Int) -> UIImage? {
        
        let headerRectSize = CGSize(width: self.bounds.size.width, height: self.rectForHeader(inSection: section).size.height)
        
        return UIImage.imageWithColor(color: UIColor.clear, size:headerRectSize)
    }
    
    func blankScreenshotOfFooterAtSection(section:Int) -> UIImage? {
        let footerRectSize = CGSize(width: self.bounds.size.width, height: self.rectForFooter(inSection: section).size.height)
        return UIImage.imageWithColor(color: UIColor.clear, size:footerRectSize)
    }
    
    var allSectionsIndexes : [Int]
    {
        let numSections = self.numberOfSections
        
        var allSectionsIndexes = [Int]()
        
        for section in 0..<numSections {
            allSectionsIndexes.append(section)
        }
        return allSectionsIndexes
    }
    
    
    var allRowsIndexPaths : [NSIndexPath] {
        var allRowsIndexPaths = [NSIndexPath]()
        for sectionIdx in self.allSectionsIndexes {
            for rowNum in 0..<self.numberOfRows(inSection: sectionIdx) {
                let indexPath = NSIndexPath(row: rowNum, section: sectionIdx)
                allRowsIndexPaths.append(indexPath)
            }
        }
        return allRowsIndexPaths;
    }
    
}
