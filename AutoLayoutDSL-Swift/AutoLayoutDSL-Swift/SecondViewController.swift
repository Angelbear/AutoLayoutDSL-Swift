//
//  SecondViewController.swift
//  AutoLayoutDSL-Swift
//
//  Created by yangyang on 15/7/12.
//  Copyright (c) 2015年 Angelbear. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    private var blackView: UIView!
    private var whiteLabel: UILabel!
    
    private func initSubViews() {
        self.blackView = UIView()
        self.blackView.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(self.blackView)
        
        self.blackView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.view => self.blackView.left == self.view.left + 10
        => self.blackView.right == self.view.right - 10
        
        self.whiteLabel = UILabel()
        self.whiteLabel.textColor = UIColor.whiteColor()
        self.whiteLabel.numberOfLines = 0
        self.whiteLabel.text = "black view top : bottom margin is 3 : 2 and white label's content margin is (10, 10, 10, 10)"
        self.whiteLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, forAxis: .Horizontal)
        self.whiteLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, forAxis: .Vertical)
        
        self.blackView.addSubview(self.whiteLabel)
        
        self.whiteLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.blackView => self.whiteLabel.top == self.blackView.top + 10
        => self.whiteLabel.left == self.blackView.left + 10
        => self.whiteLabel.right == self.blackView.right - 10
        ~~> self.whiteLabel.bottom == self.blackView.bottom - 10
        
        
        var topMarginView = UIView()
        topMarginView.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(topMarginView)
        
        topMarginView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.view => topMarginView.centerX == self.view.centerX
        => topMarginView.top == self.view.top
        => topMarginView.bottom == self.blackView.top
        => topMarginView.width == 0
        
        
        var bottomMarginView = UIView()
        
        bottomMarginView.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(bottomMarginView)
        
        bottomMarginView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.view => bottomMarginView.centerX == self.view.centerX
        => bottomMarginView.top == self.blackView.bottom
        => bottomMarginView.bottom == self.view.bottom
        => bottomMarginView.width == 0
        
        self.view => topMarginView.height == bottomMarginView.height * 1.5
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initSubViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

