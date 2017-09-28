//
//  AutoLayoutDSL_SwiftTests.swift
//  AutoLayoutDSL-SwiftTests
//
//  Created by yangyang on 15/7/12.
//  Copyright (c) 2015 Angelbear. All rights reserved.
//

import UIKit
import XCTest

class AutoLayoutDSL_SwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testForSimpleCase() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let view1 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view1)
        
        view => view.height == 100
            => view.width == 100
        
        view => view1.left == view.left
        => view1.right == view.right
        => view1.top == view.top
        => view1.bottom == view.bottom
        
        view.layoutIfNeeded()
        
        XCTAssertEqual(true, CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height) == view1.frame, "view1 should have same frame as view")
    }

    
    func testForOperations() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let view1 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view1)
        
        view => view.height == 100
            => view.width == 100
        
        view => view1.left == view.left + 10
            => view1.top == view.top - 10
            => view1.height == view.height / 2
            => view1.width == view.width * 3
        
        view.layoutIfNeeded()
        
        XCTAssertEqual(true, CGRect(x: 10, y: -10, width: 300, height: 50) == view1.frame, "view1 should be (10, -10, 300, 50)")
    }
    
    func testPriorities() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let view1 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view1)
        
        view => view.height == 100
            => view.width == 100
        
        view => view1.left == view.left + 10
            ~~> view1.top == view.top - 10
            ~~~> view1.height == view.height / 2
            => view1.width == view.width * 3
        
        view.layoutIfNeeded()
        
        XCTAssertEqual(true, CGRect(x: 10, y: -10, width: 300, height: 50) == view1.frame, "view1 should be (10, -10, 300, 50)")
        
        for constraint: NSLayoutConstraint in view.constraints {
            if constraint.firstItem as! NSObject == view1 {
                if constraint.firstAttribute == .top {
                    XCTAssertEqual(UILayoutPriorityDefaultHigh, constraint.priority, "~~> will set priority to UILayoutPriorityDefaultHigh")
                } else if constraint.firstAttribute == .height {
                    XCTAssertEqual(UILayoutPriorityDefaultLow, constraint.priority, "~~~> will set priority to UILayoutPriorityDefaultLow")
                } else {
                    XCTAssertEqual(UILayoutPriorityRequired, constraint.priority, "=> will not change priority")
                }
            }
        }
    }

    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
