//
//  EditField.swift
//  ArtistPad-ios-swift
//
//  Created by Eli Brown on 3/24/16.
//  Copyright © 2016 Eli Brown. All rights reserved.
//
import Foundation
import UIKit

class LinedView : UITextView {
    let fontSize : CGFloat = 20;
    var padding : CGFloat!;
    
    override func drawRect(rect: CGRect) {
        //changes the size of the font.
        font = UIFont.boldSystemFontOfSize(fontSize);
        //sets the padding to the lined textView.
        textContainerInset = UIEdgeInsetsMake(0, 15, 0, 15);
        padding = textContainer.lineFragmentPadding;
        drawVerticalLines(rect);
        drawHerizontalLines(rect);
        
    }
    
    /*
     Function for drawing the herizontal lines on the textView.
     */
    func drawHerizontalLines(rect : CGRect){
        UIColor.blueColor().set();
        let context = UIGraphicsGetCurrentContext();
        CGContextSetLineJoin(context, .Round);
        var i = fontSize;
        while i < rect.height{
            CGContextMoveToPoint(context, 0, i);
            CGContextAddLineToPoint(context, rect.width, i);
            CGContextStrokePath(context);
            i += (fontSize + padding);
        }
    }
    
    /*
     Function for drawing vertical lines on the textView.
     */
    func drawVerticalLines(rect : CGRect){
        UIColor.orangeColor().set();
        let context = UIGraphicsGetCurrentContext();
        CGContextSetLineJoin(context, .Round);
        
        CGContextMoveToPoint(context, 10, 0);
        CGContextAddLineToPoint(context, 10, rect.height);
        
        CGContextMoveToPoint(context, 15, 0);
        CGContextAddLineToPoint(context, 15, rect.height);
        CGContextStrokePath(context);
    }
}