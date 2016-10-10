//
//  Extension.swift
//  Weather
//
//  Created by Pierre on 9/30/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

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
