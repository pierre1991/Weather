//
//  Extension.swift
//  Weather
//
//  Created by Pierre on 9/30/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element: Equatable {
    
    public func uniq() -> [Element] {
        var arrayCopy = self
        arrayCopy.uniqInPlace()
        
        return arrayCopy
    }
    
    mutating public func uniqInPlace() {
        var seen = [Element]()
        var index = 0
        for element in self {
            if seen.contains(element) {
                remove(at: index)
            } else {
                seen.append(element)
                index += 1
            }
        }
    }
}

extension Array where Element: Equatable {
    
    mutating func distinct() {
        var uniqueElements: [Element] = []
        
        for elem in self {
            if !uniqueElements.contains(elem) {
                uniqueElements.append(elem)
            }
        }
        
        self = uniqueElements
    }
}



func uniq<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {

    var buffer = [T]()
    var added = Set<T>()
    
    for elem in source {
        if !added.contains(elem) {
            buffer.append(elem)
            added.insert(elem)
        }
    }
    return buffer
}


extension UIView {
    
    class func loadFromNibNamed(nibNamed: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: nibNamed, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
}


