//
//  DSCCustomSearchBar.swift
//  DreamStudioUIComponets
//
//  Created by wangyunpeng on 16/8/8.
//  Copyright © 2016年 dreamstudio. All rights reserved.
//

import UIKit

public protocol XMRCustomSearchBarDelegate : class { // 要求实现delegate的必须是一个类！
    func searchBarTextDidChange(searchBar : DSCCustomSearchBar, searchText : String)
    func searchButtonClicked(searchBar : DSCCustomSearchBar)
    func cancelButtonClicked(searchBar : DSCCustomSearchBar)
    func searchBarDidBecomeFirstResponder(searchBar : DSCCustomSearchBar)
    func searchBarDidResignFirstResponder(searchBar : DSCCustomSearchBar)
}

public class DSCCustomSearchBar: UIView, UITextFieldDelegate {
    public weak var delegate : XMRCustomSearchBarDelegate?
    public var placeHolder : String? {
        didSet {
            self.textField?.placeholder = placeHolder
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.customUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customUI()
    }
    
    var backgroundImageView : UIImageView? = nil
    var backgroundCycle : UIImageView? = nil
    var magnifier : UIImageView? = nil
    var textField : DSCCustomTextField? = nil
    var cancelButton : UIButton? = nil
    var clearButton : UIButton? = nil
    var currentString : String? = nil
    
    func customUI() {
        self.backgroundCycle = UIImageView(frame: CGRect(x: 15, y: (self.frame.size.height - 30) / 2, width: self.frame.size.width - 30, height: 30))
        
        self.backgroundCycle!.image = UIImage(named:"frame_input_bg")?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 15, 0, 15))
        self.addSubview(self.backgroundCycle!)
        
        var left : CGFloat = self.backgroundCycle!.frame.origin.x + 10
        self.magnifier = UIImageView(frame: CGRect(x: left, y: (self.frame.size.height - 14) / 2.0, width: 14, height: 14))
        self.magnifier!.image = UIImage(named:"frame_search_icon")
        self.addSubview(self.magnifier!)
        
        left += (14 + 5)
        self.textField = DSCCustomTextField(frame:CGRect(x: left, y: (self.frame.size.height - 30) / 2.0, width: self.frame.size.width - left - 45, height: 30))
        self.textField!.returnKeyType = UIReturnKeyType.search
        self.textField!.textColor = UIColor.white()
        self.textField!.tintColor = UIColor.white()
        self.textField!.font = UIFont.systemFont(ofSize: 14)
        self.textField!.delegate = self
        self.textField!.addTarget(self, action:#selector(changeSearchContent(_:)), for: UIControlEvents.editingChanged)
        self.addSubview(self.textField!)
        
        left += self.textField!.frame.size.width
        self.clearButton = UIButton(type: UIButtonType.custom)
        self.clearButton!.frame = CGRect(x: left, y: (self.frame.size.height - 24) / 2.0, width: 24, height: 24)
        self.clearButton!.setImage(UIImage(named:"frame_delete_icon_highlight"), for: UIControlState.normal)
        self.clearButton!.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        self.clearButton!.isEnabled = false
        self.addSubview(self.clearButton!)
        self.backgroundColor = UIColor(red: 212.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1.0)
    }
    
    var text : String? {
        get {
            return self.textField?.text;
        }
        
        set {
            self.textField?.text = text
            if let text = self.textField?.text {
                if (!text.isEmpty) {
                    self.clearButton?.isEnabled = true
                }
            }
        }
    }
    
    var textFieldFrame : CGRect? {
        get {
            return self.backgroundCycle?.frame
        }
    }
    
    public override func becomeFirstResponder() -> Bool {
        if let textField = self.textField {
            return textField.becomeFirstResponder()
        }
        else {
            return false
        }
    }
    
    public override func resignFirstResponder() -> Bool {
        self.backgroundCycle?.image = UIImage(named:"frame_input_bg")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        
        return self.isFirstResponder()
    }
    
    public override func isFirstResponder() -> Bool {
        if let textField = self.textField {
            return textField.isFirstResponder()
        }
        else {
            return false
        }
    }
    
// MARK:- action
    func cancelButtonPressed(_ cancelButton: UIButton) {
        self.textField?.text = ""
        self.textField?.resignFirstResponder()
        self.delegate?.cancelButtonClicked(searchBar: self)
    }
    
    func clearButtonPressed(_ clearButton: UIButton) {
        self.clearButton?.isEnabled = false
        self.textField?.text = ""
        self.textField?.becomeFirstResponder()
        self.delegate?.searchButtonClicked(searchBar: self)
    }
    
    func changeSearchContent(_ textField: UITextField) {
        if nil == textField.text || (textField.text!.characters.count > 0 && textField.text == self.currentString) {
            return
        }
        
        self.currentString = textField.text;
        self.clearButton?.isEnabled = !(textField.text!.characters.count == 0)
        self.delegate?.searchBarTextDidChange(searchBar: self, searchText: textField.text!)
    }
    
// MARK:- UITextFieldDelegate
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.searchBarDidBecomeFirstResponder(searchBar: self)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.searchBarDidResignFirstResponder(searchBar: self)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.backgroundCycle?.image = UIImage(named: "frame_input_bg_highlight")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.searchButtonClicked(searchBar: self)
        return true
    }
}

