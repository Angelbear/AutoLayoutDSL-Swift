//
//  FirstViewController.swift
//  AutoLayoutDSL-Swift
//
//  Created by yangyang on 15/7/12.
//  Copyright (c) 2015年 Angelbear. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    private var redView: UIView!
    private var greenView: UIView!
    private var yellowView: UIView!
    
    private func initSubViews() {
        self.redView = UIView()
        self.redView.backgroundColor = UIColor.redColor()
        
        self.view.addSubview(self.redView)
        
        self.redView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.view => self.redView.left == self.view.left + 10
        => self.redView.right == self.view.right - 10
        => self.redView.top == self.view.top + 30
        => self.redView.height == 100
        
        var redViewLabel = UILabel()
        redViewLabel.textColor = UIColor.blackColor()
        redViewLabel.numberOfLines = 0
        
        redViewLabel.text = "self.redView.left == self.view.left + 10\nself.redView.right == self.view.right - 10\nself.redView.top == self.view.top + 30\nself.redView.height == 100"
        
        self.redView.addSubview(redViewLabel)
        redViewLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.redView => redViewLabel.centerX == self.redView.centerX
        => redViewLabel.centerY == self.redView.centerY
        => redViewLabel.left == self.redView.left + 10
        => redViewLabel.right == self.redView.right - 10
        
        self.greenView = UIView()
        self.greenView.backgroundColor = UIColor.greenColor()
        
        self.view.addSubview(self.greenView)
        
        self.greenView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.yellowView = UIView()
        self.yellowView.backgroundColor = UIColor.yellowColor()
        
        self.view.addSubview(self.yellowView)
        
        self.yellowView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.view => self.greenView.width == self.yellowView.width * 2
        => self.greenView.left == self.view.left + 10
        => self.greenView.top == self.redView.bottom + 10
        => self.greenView.right == self.yellowView.left - 20
        => self.greenView.bottom == self.view.bottom - 60
        => self.yellowView.height == self.greenView.height
        => self.yellowView.right == self.view.right - 10
        => self.yellowView.top == self.greenView.top
        
        
        var greenViewLabel = UILabel()
        greenViewLabel.textColor = UIColor.blackColor()
        greenViewLabel.numberOfLines = 0
        
        greenViewLabel.text = "self.greenView.width == self.yellowView.width * 2\nself.greenView.left == self.view.left + 10\nself.greenView.top == self.redView.bottom + 10\nself.greenView.right == self.yellowView.left - 20\nself.greenView.bottom == self.view.bottom - 60"
        
        self.greenView.addSubview(greenViewLabel)
        
        greenViewLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.greenView => greenViewLabel.centerX == self.greenView.centerX
            => greenViewLabel.centerY == self.greenView.centerY
            => greenViewLabel.left == self.greenView.left + 10
            => greenViewLabel.right == self.greenView.right - 10
        
        var yellowViewLabel = UILabel()
        yellowViewLabel.textColor = UIColor.blackColor()
        yellowViewLabel.numberOfLines = 0
        
        yellowViewLabel.text = "self.yellowView.height == self.greenView.height\nself.yellowView.right == self.view.right - 10\nself.yellowView.top == self.greenView.top"
        
        self.yellowView.addSubview(yellowViewLabel)
        
        yellowViewLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.yellowView => yellowViewLabel.centerX == self.yellowView.centerX
            => yellowViewLabel.centerY == self.yellowView.centerY
            => yellowViewLabel.left == self.yellowView.left + 10
            => yellowViewLabel.right == self.yellowView.right - 10

        
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

