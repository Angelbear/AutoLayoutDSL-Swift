//
//  AutoLayoutDSK-Swift.swift
//  Angelbear
//
//  Created by yangyang on 15/6/14.
//  Copyright (c) 2015 Angelbear. All rights reserved.
//

import UIKit

let UILayoutPriorityDefaultHigh = 750 as Float
let UILayoutPriorityDefaultLow = 250 as Float
let UILayoutPriorityRequired = 1000 as Float

extension NSLayoutConstraint {
    public convenience init(item view1: AnyObject, attribute attr1: NSLayoutAttribute, relatedBy relation: NSLayoutRelation, toItem view2: AnyObject?, attribute attr2: NSLayoutAttribute, multiplier: CGFloat, constant c: CGFloat, priority: UILayoutPriority) {
        self.init(item: view1, attribute: attr1, relatedBy: relation, toItem: view2, attribute: attr2, multiplier: multiplier, constant: c)
        self.priority = priority
    }
}

public class NSLayoutConstraintBuilder {
    
    public class DestinationComponent {
        var component: Component!
        var multiplier: CGFloat = 1
        var constant: CGFloat = 0
        
        public init(component: Component) {
            self.component = component
        }
        
        public func setConstant(constant: CGFloat) -> Self {
            self.constant = constant
            return self
        }
        
        public func setMultiplier(multiplier: CGFloat) -> Self {
            self.multiplier = multiplier
            return self
        }
    }
    
    public class Component {
        var view: UIView?
        var attribute: NSLayoutAttribute!
        
        public init(view: UIView?, attribute: NSLayoutAttribute) {
            self.view = view
            self.attribute = attribute
        }
        
        private func createBuilder(component: DestinationComponent, relation: NSLayoutRelation) -> NSLayoutConstraintBuilder {
            let builder = NSLayoutConstraintBuilder()
            builder.sourceComponent = self
            builder.destinationComponent = component
            builder.relation = relation
            return builder
        }
        
        public func equal(component: DestinationComponent) -> NSLayoutConstraintBuilder {
            return createBuilder(component: component, relation: .equal)
        }
        
        public func greaterThanOrEqual(component: DestinationComponent) -> NSLayoutConstraintBuilder {
            return createBuilder(component: component, relation: .greaterThanOrEqual)
        }
        
        public func lessThanOrEqual(component: DestinationComponent) -> NSLayoutConstraintBuilder {
            return createBuilder(component: component, relation: .lessThanOrEqual)
        }
        
        public func equal(constant: CGFloat) -> NSLayoutConstraintBuilder {
            return createBuilder(component: DestinationComponent(component: Component(view: nil, attribute: .notAnAttribute)).setConstant(constant: constant), relation: .equal)
        }
        
        public func greaterThanOrEqual(constant: CGFloat) -> NSLayoutConstraintBuilder {
            return createBuilder(component: DestinationComponent(component: Component(view: nil, attribute: .notAnAttribute)).setConstant(constant: constant), relation: .greaterThanOrEqual)
        }
        
        public func lessThanOrEqual(constant: CGFloat) -> NSLayoutConstraintBuilder {
            return createBuilder(component: DestinationComponent(component: Component(view: nil, attribute: .notAnAttribute)).setConstant(constant: constant), relation: .lessThanOrEqual)
        }
    }
    
    var sourceComponent: Component!
    var relation: NSLayoutRelation!
    var destinationComponent: DestinationComponent!
    var layoutPrority: UILayoutPriority = UILayoutPriorityRequired
    
    public func setPriority(priority: UILayoutPriority) -> Self {
        self.layoutPrority = priority
        return self
    }
    
    public func build() -> NSLayoutConstraint {
        return NSLayoutConstraint(item: sourceComponent.view!, attribute: sourceComponent.attribute, relatedBy: relation, toItem: destinationComponent.component.view, attribute: destinationComponent.component.attribute, multiplier: destinationComponent.multiplier, constant: destinationComponent.constant, priority: layoutPrority)
    }
}

extension UIView {
    private func attribute(attribute: NSLayoutAttribute) -> NSLayoutConstraintBuilder.Component {
        return NSLayoutConstraintBuilder.Component(view: self, attribute: attribute)
    }
    
    public var left: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(attribute: .left)
        }
    }
    
    public var right: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(attribute: .right)
        }
    }
    
    public var top: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(attribute: .top)
        }
    }
    
    public var bottom: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(attribute: .bottom)
        }
    }
    
    public var centerX: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(attribute: .centerX)
        }
    }
    
    public var centerY: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(attribute: .centerY)
        }
    }
    
    public var width: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(attribute: .width)
        }
    }
    
    public var height: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(attribute: .height)
        }
    }
    
    public var leading: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(attribute: .leading)
        }
    }
    
    public var trailing: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(attribute: .trailing)
        }
    }
    
    public var baseline: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(attribute: .lastBaseline)
        }
    }
}

// Usage
// sourceView.sourceAttribute = destinationView.destinationAttribute (*|/) multiplier (+|-) constant
// * Support chain operions and will follow operation precedence to re-calculate multipliers and constaints
public func == (component: NSLayoutConstraintBuilder.Component, destinationComponent: NSLayoutConstraintBuilder.DestinationComponent) -> NSLayoutConstraint {
    let builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = destinationComponent
    builder.relation = .equal
    return builder.build()
}

public func == (component: NSLayoutConstraintBuilder.Component, destinationComponent: NSLayoutConstraintBuilder.Component) -> NSLayoutConstraint {
    let builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = NSLayoutConstraintBuilder.DestinationComponent(component: destinationComponent)
    builder.relation = .equal
    return builder.build()
}

public func == (component: NSLayoutConstraintBuilder.Component, constant: CGFloat) -> NSLayoutConstraint {
    let builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = NSLayoutConstraintBuilder.DestinationComponent(component: NSLayoutConstraintBuilder.Component(view: nil, attribute: .notAnAttribute)).setConstant(constant: constant)
    builder.relation = .equal
    return builder.build()
}

public func >= (component: NSLayoutConstraintBuilder.Component, destinationComponent: NSLayoutConstraintBuilder.DestinationComponent) -> NSLayoutConstraint {
    let builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = destinationComponent
    builder.relation = .greaterThanOrEqual
    return builder.build()
}

public func >= (component: NSLayoutConstraintBuilder.Component, destinationComponent: NSLayoutConstraintBuilder.Component) -> NSLayoutConstraint {
    let builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = NSLayoutConstraintBuilder.DestinationComponent(component: destinationComponent)
    builder.relation = .greaterThanOrEqual
    return builder.build()
}

public func >= (component: NSLayoutConstraintBuilder.Component, constant: CGFloat) -> NSLayoutConstraint {
    let builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = NSLayoutConstraintBuilder.DestinationComponent(component: NSLayoutConstraintBuilder.Component(view: nil, attribute: .notAnAttribute)).setConstant(constant: constant)
    builder.relation = .greaterThanOrEqual
    return builder.build()
}

public func <= (component: NSLayoutConstraintBuilder.Component, destinationComponent: NSLayoutConstraintBuilder.DestinationComponent) -> NSLayoutConstraint {
    let builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = destinationComponent
    builder.relation = .lessThanOrEqual
    return builder.build()
}

public func <= (component: NSLayoutConstraintBuilder.Component, destinationComponent: NSLayoutConstraintBuilder.Component) -> NSLayoutConstraint {
    let builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = NSLayoutConstraintBuilder.DestinationComponent(component: destinationComponent)
    builder.relation = .lessThanOrEqual
    return builder.build()
}

public func <= (component: NSLayoutConstraintBuilder.Component, constant: CGFloat) -> NSLayoutConstraint {
    let builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = NSLayoutConstraintBuilder.DestinationComponent(component: NSLayoutConstraintBuilder.Component(view: nil, attribute: .notAnAttribute)).setConstant(constant: constant)
    builder.relation = .lessThanOrEqual
    return builder.build()
}

public func * (component: NSLayoutConstraintBuilder.Component, multiplier: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return NSLayoutConstraintBuilder.DestinationComponent(component: component).setMultiplier(multiplier: multiplier)
}

public func * (component: NSLayoutConstraintBuilder.DestinationComponent, multiplier: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return component.setMultiplier(multiplier: component.multiplier * multiplier).setConstant(constant: component.constant * multiplier)
}

public func / (component: NSLayoutConstraintBuilder.Component, multiplier: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return NSLayoutConstraintBuilder.DestinationComponent(component: component).setMultiplier(multiplier:  1.0 / multiplier)
}

public func / (component: NSLayoutConstraintBuilder.DestinationComponent, multiplier: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return component.setMultiplier(multiplier: component.multiplier / multiplier).setConstant(constant: component.constant / multiplier)
}

public func + (component: NSLayoutConstraintBuilder.Component, constant: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return NSLayoutConstraintBuilder.DestinationComponent(component: component).setConstant(constant: constant)
}

public func + (component: NSLayoutConstraintBuilder.DestinationComponent, constant: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return component.setConstant(constant: component.constant + constant)
}

public func - (component: NSLayoutConstraintBuilder.Component, contant: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return NSLayoutConstraintBuilder.DestinationComponent(component: component).setConstant(constant: -contant)
}

public func - (component: NSLayoutConstraintBuilder.DestinationComponent, constant: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return component.setConstant(constant: component.constant - constant)
}

precedencegroup AssignConstraint {
    associativity: left
    lowerThan: ComparisonPrecedence
}

// Help Function for adding NSLayoutConstaint的
// => dont change c=priority, default is UILayoutPriorityRequired
// ~~> change priority to UILayoutPriorityDefaultHigh(750)
// ~~~> change priority to UILayoutPriorityDefaultLow(250)
// Operations will return view itself
// we set precedence ot 120，so that it will be lower than ==, <=, >=
// reference swift operation precedence from http://nshipster.com/swift-operators/
infix operator => : AssignConstraint
public func => (view: UIView, constaint: NSLayoutConstraint) -> UIView {
    view.addConstraint(constaint)
    return view
}

infix operator ~~> : AssignConstraint
public func ~~> (view: UIView, constaint: NSLayoutConstraint) -> UIView  {
    constaint.priority = UILayoutPriorityDefaultHigh
    view.addConstraint(constaint)
    return view
}

infix operator ~~~> : AssignConstraint
public func ~~~> (view: UIView, constaint: NSLayoutConstraint) -> UIView  {
    constaint.priority = UILayoutPriorityDefaultLow
    view.addConstraint(constaint)
    return view
}
