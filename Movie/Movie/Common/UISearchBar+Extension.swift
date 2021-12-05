//
//  UISearchBar+Extension.swift
//  Movie
//
//  Created by Thành Ngô Văn on 05/12/2021.
//

import Foundation
import UIKit

extension UISearchBar {
    fileprivate var textField: UITextField? {
        let subViews = self.subviews.flatMap { $0.subviews }
        if let _subViews = subViews.last?.subviews {
            return (_subViews.filter { $0 is UITextField }).first as? UITextField
        }else{
            return nil
        }
    }
    
}

class SearchBarLoadable: UISearchBar {
    
    private var searchView: UIView?
    
    private var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.compactMap{ $0 as? UIActivityIndicatorView }.first
    }
    
    var isLoading: Bool {
        get {
            return activityIndicator != nil
        }
        set {
            
            searchView = searchView == nil ? textField?.leftView : searchView
            if newValue {
                if activityIndicator == nil {
                    let _activityIndicator = UIActivityIndicatorView(style: .medium)
                    _activityIndicator.startAnimating()
                    _activityIndicator.backgroundColor = UIColor.clear

                    textField?.leftViewMode = .always
                    textField?.leftView = _activityIndicator
                }
            } else {
                textField?.leftView = searchView
                activityIndicator?.stopAnimating()
                activityIndicator?.removeFromSuperview()
            }
        }
    }
}
