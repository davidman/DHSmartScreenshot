DHSmartScreenshot
=================

UITableView Category to get really easy, smart and instant screenshot images like no other library out there for iOS 5+ devices.


Screenshots
-----------
This is a tableview on the simulator:

![iOS TableView on Simulator](http://i.imgur.com/oIZJ5bT.png)

And here is the full screenshot image that you get (selecting the first row, naturally):

![Screenshot Taken - Example](http://i.imgur.com/w6UkZCD.png)


Installation
------------
1. The preferred way of installation is via [Cocoapods](http://cocoapods.org). Just add 

```ruby
pod 'DHSmartScreenshot'
```

and run `pod install`. It will install the most recent version of DHSmartScreenshot.


How to use
----------
There are some methods to customize the way you want to take the screenshot.
Each one of them is self descriptive and works as you could expect, take a look:

```objective-c
- (UIImage *)screenshot;
```

```objective-c
- (UIImage *)screenshotOfCellAtIndexPath:(NSIndexPath *)indexPath;
```

```objective-c
- (UIImage *)screenshotOfHeaderViewAtSection:(NSUInteger)section;
```

```objective-c
- (UIImage *)screenshotOfFooterViewAtSection:(NSUInteger)section;
```

```objective-c
- (UIImage *)screenshotExcludingAllHeaders:(BOOL)withoutHeaders
					   excludingAllFooters:(BOOL)withoutFooters
						  excludingAllRows:(BOOL)withoutRows;
```

```objective-c
- (UIImage *)screenshotExcludingHeadersAtSections:(NSSet *)headerSections
					   excludingFootersAtSections:(NSSet *)footerSections
						excludingRowsAtIndexPaths:(NSSet *)indexPaths;
```

```objective-c
- (UIImage *)screenshotOfHeadersAtSections:(NSSet *)headerSections
						 footersAtSections:(NSSet *)footerSections
						  rowsAtIndexPaths:(NSSet *)indexPaths;
```

Example
-------

In order to get a full screenshot image out from a UITableView instance you just need 1 line

```objective-c
UIImage * tableViewScreenshot = [self.tableView screenshot];
```


Contribution
------------

Sure :) please send a pull-request or raise an issue. It is always good to know how to make things better, yay!


Author
------

David Hernandez ([dav.viidd94@gmail.com](mailto:dav.viidd94@gmail.com))


License
-------

UITableView-DHSmartScreenshot is under the MIT License.
