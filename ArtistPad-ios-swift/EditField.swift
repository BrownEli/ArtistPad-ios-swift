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
    
    override func drawRect(rect: CGRect) {
        font = UIFont.boldSystemFontOfSize((rect.height / fontSize) - textContainer.lineFragmentPadding);
        backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3);
        textContainerInset = UIEdgeInsetsMake(0, 15, 0, 15);
        drawVerticalLines(rect);
        drawHerizontalLines(rect);
    }
    
    func drawHerizontalLines(rect : CGRect){
        UIColor.blueColor().set();
        let context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1);
        CGContextSetLineJoin(context, .Round);
        
        for var i = fontSize; i < rect.height; i += fontSize{
            CGContextMoveToPoint(context, 0, i);
            CGContextAddLineToPoint(context, rect.width, i);
            CGContextStrokePath(context);
        }
    }
    
    func drawVerticalLines(rect : CGRect){
        UIColor.orangeColor().set();
        let context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1);
        CGContextSetLineJoin(context, .Round);
        
        CGContextMoveToPoint(context, 10, 0);
        CGContextAddLineToPoint(context, 10, rect.height);
        
        CGContextMoveToPoint(context, 15, 0);
        CGContextAddLineToPoint(context, 15, rect.height);
        CGContextStrokePath(context);
    }
}