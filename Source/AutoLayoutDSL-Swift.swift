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
    convenience init(item view1: AnyObject, attribute attr1: NSLayoutAttribute, relatedBy relation: NSLayoutRelation, toItem view2: AnyObject?, attribute attr2: NSLayoutAttribute, multiplier: CGFloat, constant c: CGFloat, priority: UILayoutPriority) {
        self.init(item: view1, attribute: attr1, relatedBy: relation, toItem: view2, attribute: attr2, multiplier: multiplier, constant: c)
        self.priority = priority
    }
}

class NSLayoutConstraintBuilder {
    
    class DestinationComponent {
        private var component: Component!
        var multiplier: CGFloat = 1
        var constant: CGFloat = 0
        
        init(component: Component) {
            self.component = component
        }
        
        func setConstant(constant: CGFloat) -> Self {
            self.constant = constant
            return self
        }
        
        func setMultiplier(multiplier: CGFloat) -> Self {
            self.multiplier = multiplier
            return self
        }
    }
    
    class Component {
        private var view: UIView?
        private var attribute: NSLayoutAttribute!
        
        init(view: UIView?, attribute: NSLayoutAttribute) {
            self.view = view
            self.attribute = attribute
        }
        
        private func createBuilder(component: DestinationComponent, relation: NSLayoutRelation) -> NSLayoutConstraintBuilder {
            var builder = NSLayoutConstraintBuilder()
            builder.sourceComponent = self
            builder.destinationComponent = component
            builder.relation = relation
            return builder
        }
        
        func equal(component: DestinationComponent) -> NSLayoutConstraintBuilder {
            return createBuilder(component, relation: .Equal)
        }
        
        func greaterThanOrEqual(component: DestinationComponent) -> NSLayoutConstraintBuilder {
            return createBuilder(component, relation: .GreaterThanOrEqual)
        }
        
        func lessThanOrEqual(component: DestinationComponent) -> NSLayoutConstraintBuilder {
            return createBuilder(component, relation: .LessThanOrEqual)
        }
        
        func equal(constant: CGFloat) -> NSLayoutConstraintBuilder {
            return createBuilder(DestinationComponent(component: Component(view: nil, attribute: .NotAnAttribute)).setConstant(constant), relation: .Equal)
        }
        
        func greaterThanOrEqual(constant: CGFloat) -> NSLayoutConstraintBuilder {
            return createBuilder(DestinationComponent(component: Component(view: nil, attribute: .NotAnAttribute)).setConstant(constant), relation: .GreaterThanOrEqual)
        }
        
        func lessThanOrEqual(constant: CGFloat) -> NSLayoutConstraintBuilder {
            return createBuilder(DestinationComponent(component: Component(view: nil, attribute: .NotAnAttribute)).setConstant(constant), relation: .LessThanOrEqual)
        }
    }
    
    private var sourceComponent: Component!
    private var relation: NSLayoutRelation!
    private var destinationComponent: DestinationComponent!
    private var layoutPrority: UILayoutPriority = UILayoutPriorityRequired

    
    func setPriority(priority: UILayoutPriority) -> Self {
        self.layoutPrority = priority
        return self
    }
    
    func build() -> NSLayoutConstraint {
        return NSLayoutConstraint(item: sourceComponent.view!, attribute: sourceComponent.attribute, relatedBy: relation, toItem: destinationComponent.component.view, attribute: destinationComponent.component.attribute, multiplier: destinationComponent.multiplier, constant: destinationComponent.constant, priority: layoutPrority)
    }
}

extension UIView {
    private func attribute(attribute: NSLayoutAttribute) -> NSLayoutConstraintBuilder.Component {
        return NSLayoutConstraintBuilder.Component(view: self, attribute: attribute)
    }
    
    var left: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(.Left)
        }
    }
    
    var right: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(.Right)
        }
    }
    
    var top: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(.Top)
        }
    }
    
    var bottom: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(.Bottom)
        }
    }
    
    var centerX: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(.CenterX)
        }
    }
    
    var centerY: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(.CenterY)
        }
    }
    
    var width: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(.Width)
        }
    }
    
    var height: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(.Height)
        }
    }
    
    var leading: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(.Leading)
        }
    }
    
    var trailing: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(.Trailing)
        }
    }
    
    var baseline: NSLayoutConstraintBuilder.Component {
        get {
            return attribute(.Baseline)
        }
    }
    
    //TODO: add other iOS 8 only attributes and limit with api version when Swift 1.2 releases 
}

// Usage
// sourceView.sourceAttribute = destinationView.destinationAttribute (*|/) multiplier (+|-) constant
// * Support chain operions and will follow operation precedence to re-calculate multipliers and constaints
func == (component: NSLayoutConstraintBuilder.Component, destinationComponent: NSLayoutConstraintBuilder.DestinationComponent) -> NSLayoutConstraint {
    var builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = destinationComponent
    builder.relation = .Equal
    return builder.build()
}

func == (component: NSLayoutConstraintBuilder.Component, destinationComponent: NSLayoutConstraintBuilder.Component) -> NSLayoutConstraint {
    var builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = NSLayoutConstraintBuilder.DestinationComponent(component: destinationComponent)
    builder.relation = .Equal
    return builder.build()
}

func == (component: NSLayoutConstraintBuilder.Component, constant: CGFloat) -> NSLayoutConstraint {
    var builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = NSLayoutConstraintBuilder.DestinationComponent(component: NSLayoutConstraintBuilder.Component(view: nil, attribute: .NotAnAttribute)).setConstant(constant)
    builder.relation = .Equal
    return builder.build()
}

func >= (component: NSLayoutConstraintBuilder.Component, destinationComponent: NSLayoutConstraintBuilder.DestinationComponent) -> NSLayoutConstraint {
    var builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = destinationComponent
    builder.relation = .GreaterThanOrEqual
    return builder.build()
}

func >= (component: NSLayoutConstraintBuilder.Component, destinationComponent: NSLayoutConstraintBuilder.Component) -> NSLayoutConstraint {
    var builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = NSLayoutConstraintBuilder.DestinationComponent(component: destinationComponent)
    builder.relation = .GreaterThanOrEqual
    return builder.build()
}

func >= (component: NSLayoutConstraintBuilder.Component, constant: CGFloat) -> NSLayoutConstraint {
    var builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = NSLayoutConstraintBuilder.DestinationComponent(component: NSLayoutConstraintBuilder.Component(view: nil, attribute: .NotAnAttribute)).setConstant(constant)
    builder.relation = .GreaterThanOrEqual
    return builder.build()
}

func <= (component: NSLayoutConstraintBuilder.Component, destinationComponent: NSLayoutConstraintBuilder.DestinationComponent) -> NSLayoutConstraint {
    var builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = destinationComponent
    builder.relation = .LessThanOrEqual
    return builder.build()
}

func <= (component: NSLayoutConstraintBuilder.Component, destinationComponent: NSLayoutConstraintBuilder.Component) -> NSLayoutConstraint {
    var builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = NSLayoutConstraintBuilder.DestinationComponent(component: destinationComponent)
    builder.relation = .LessThanOrEqual
    return builder.build()
}

func <= (component: NSLayoutConstraintBuilder.Component, constant: CGFloat) -> NSLayoutConstraint {
    var builder =  NSLayoutConstraintBuilder()
    builder.sourceComponent = component
    builder.destinationComponent = NSLayoutConstraintBuilder.DestinationComponent(component: NSLayoutConstraintBuilder.Component(view: nil, attribute: .NotAnAttribute)).setConstant(constant)
    builder.relation = .LessThanOrEqual
    return builder.build()
}

func * (component: NSLayoutConstraintBuilder.Component, multiplier: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return NSLayoutConstraintBuilder.DestinationComponent(component: component).setMultiplier(multiplier)
}

func * (component: NSLayoutConstraintBuilder.DestinationComponent, multiplier: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return component.setMultiplier(component.multiplier * multiplier).setConstant(component.constant * multiplier)
}

func / (component: NSLayoutConstraintBuilder.Component, multiplier: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return NSLayoutConstraintBuilder.DestinationComponent(component: component).setMultiplier( 1.0 / multiplier)
}

func / (component: NSLayoutConstraintBuilder.DestinationComponent, multiplier: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return component.setMultiplier(component.multiplier / multiplier).setConstant(component.constant / multiplier)
}

func + (component: NSLayoutConstraintBuilder.Component, constant: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return NSLayoutConstraintBuilder.DestinationComponent(component: component).setConstant(constant)
}

func + (component: NSLayoutConstraintBuilder.DestinationComponent, constant: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return component.setConstant(component.constant + constant)
}

func - (component: NSLayoutConstraintBuilder.Component, contant: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return NSLayoutConstraintBuilder.DestinationComponent(component: component).setConstant(-contant)
}

func - (component: NSLayoutConstraintBuilder.DestinationComponent, constant: CGFloat) -> NSLayoutConstraintBuilder.DestinationComponent {
    return component.setConstant(component.constant - constant)
}

// Help Function for adding NSLayoutConstaint的
// => dont change c=priority, default is UILayoutPriorityRequired
// ~~> change priority to UILayoutPriorityDefaultHigh(750)
// ~~~> change priority to UILayoutPriorityDefaultLow(250)
// Operations will return view itself
// we set precedence ot 120，so that it will be lower than ==, <=, >=
// reference swift operation precedence from http://nshipster.com/swift-operators/
infix operator => { associativity left precedence 120 }
func => (view: UIView, constaint: NSLayoutConstraint) -> UIView {
    view.addConstraint(constaint)
    return view
}

infix operator ~~> { associativity left precedence 120 }
func ~~> (view: UIView, constaint: NSLayoutConstraint) -> UIView  {
    constaint.priority = UILayoutPriorityDefaultHigh
    view.addConstraint(constaint)
    return view
}

infix operator ~~~> { associativity left precedence 120 }
func ~~~> (view: UIView, constaint: NSLayoutConstraint) -> UIView  {
    constaint.priority = UILayoutPriorityDefaultLow
    view.addConstraint(constaint)
    return view
}
