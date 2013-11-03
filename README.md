StackPanelLayout
================

iOS Cocoa Touch StatckPanel with AutoLayout

This sample project illustrates how to programatically add NSLayoutConstraints to create a dynamic StackPanel using the Autolayout of iOS 5 and higher.

Simply create a subclass of StackPanelViewController, set it as the controller type for the View Controller in the storyboard or nib. Then add a UIScrollView to the main view. Ctrl-drag it to the IBOutlet scrollView in the super class of the View Controller (i.e. StackPanelViewController).

Now you can add any number of sub views to the scrollview. They will retain their relationship during layout. The height of each view can be changed in runtime by calling StackPanelViewController setHeight:(float)height forView:(UIView*)view animated:(BOOL)animate. This will update the view and push any views below it downwards and maintain the original distance to the updated view.
