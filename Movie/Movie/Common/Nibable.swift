//
//  Nibable.swift
//  Movie
//
//  Created by Thành Ngô Văn on 04/12/2021.
//

import UIKit

public protocol Nibable: AnyObject {
    static var nib: UINib { get }
    static var nibName: String { get }
}

public extension Nibable {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: Self.self), bundle: Bundle(for: self))
    }
    
    static var nibName: String {
        return String(describing: Self.self)
    }
    
    static var identifier: String {
        return nibName
    }
}

extension UIViewController: Nibable {
    
}

extension UIView: Nibable {
    
}
