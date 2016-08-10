//
//  ViewController.swift
//  DreamStudioUIComponets
//
//  Created by wangyunpeng on 16/8/8.
//  Copyright © 2016年 dreamstudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMRCustomSearchBarDelegate {
    var dscSearchBar : DSCCustomSearchBar?
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.dscSearchBar?.delegate = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configSearchBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _ = self.dscSearchBar?.resignFirstResponder()
    }
    
// MARK:- config UI
    func configSearchBar() {
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44)
        self.dscSearchBar = DSCCustomSearchBar(frame:frame)
        let searchContentView = UIView(frame: frame)
        self.dscSearchBar!.frame = frame
        self.dscSearchBar!.placeHolder = "搜索"
        self.dscSearchBar!.delegate = self
        searchContentView.addSubview(self.dscSearchBar!)
        self.view.addSubview(searchContentView)
        searchContentView.frame.origin.y = 20
    }

    func searchBarTextDidChange(searchBar : DSCCustomSearchBar, searchText : String) {
        
    }
    
    func searchButtonClicked(searchBar : DSCCustomSearchBar) {
        
    }
    
    func cancelButtonClicked(searchBar : DSCCustomSearchBar) {
        
    }
    
    func searchBarDidBecomeFirstResponder(searchBar : DSCCustomSearchBar) {
        
    }
    
    func searchBarDidResignFirstResponder(searchBar : DSCCustomSearchBar) {
        
    }

}

