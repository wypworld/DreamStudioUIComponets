//
//  DSCCustomTextField.swift
//  DreamStudioUIComponets
//
//  Created by wangyunpeng on 16/8/9.
//  Copyright © 2016年 dreamstudio. All rights reserved.
//

import UIKit
import UIKit.NSStringDrawing

public class DSCCustomTextField: UITextField {
    public func drawPlaceholderInRect(frame : CGRect) {
        if nil == self.placeholder {
            return
        }
        
        let newFrame = CGRect(x:4.0, y:6.0, width:frame.width, height:frame.height)
        let textFont : UIFont
        if let font = self.font {
            textFont = font
        }
        else {
            textFont = UIFont.systemFont(ofSize: UIFont.systemFontSize())
        }
        
        self.placeholder?.draw(in:newFrame, withAttributes:[NSFontAttributeName : textFont, NSForegroundColorAttributeName : UIColor.init(red:1, green:1, blue:1, alpha:0.5)])
        
    }
}
