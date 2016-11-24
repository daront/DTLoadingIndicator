//
//  DTLoadingIndicator.swift
//  DTLoadingIndicator
//
//  Created by Daron Tancharoen on 7/26/16.
//  Copyright © 2016 daront. All rights reserved.
//

import Foundation
import UIKit
import FLAnimatedImage

open class DTLoadingIndicator {
    
    static let IN_VIEW_LOADING_VIEW_TAG = 98
    static let FULL_SCREEN_LOADING_VIEW_TAG = 99
    static var fullScreenPendingTaskCount = 0
    static var loadingImageName = "love.gif"
    
    static var loadingImageData: Data {
        let frameworkBundle = Bundle(for: DTLoadingIndicator.self)
        if let bundleURL = frameworkBundle.url(forResource: "DTLoadingIndicator", withExtension: "bundle") {
            // If use cocoapod, resourse files will be in a bundle named "DTLoadingIndicator".
            let bundle = Bundle(url: bundleURL)
            let resourcePath = bundle!.path(forResource: loadingImageName, ofType: nil)
            return (try! Data(contentsOf: URL(fileURLWithPath: resourcePath!)));
        } else {
            // If just copy a source file to the project, resource files will be in main bundle. (like the demo project)
            let resourcePath = Bundle.main.path(forResource: loadingImageName, ofType: nil)
            return (try! Data(contentsOf: URL(fileURLWithPath: resourcePath!)));
        }
    }
    
    @discardableResult
    open static func startFullScreenLoadingIndicator() -> UIActivityIndicatorView {
        let window = UIApplication.shared.delegate!.window!!
        if let indicator = window.viewWithTag(FULL_SCREEN_LOADING_VIEW_TAG) as? UIActivityIndicatorView {
            // loading indicator is already on screen
            return indicator
        } else {
            // loading indicator isn't on screen yet -> create one
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            indicator.tag = FULL_SCREEN_LOADING_VIEW_TAG
            
            // make the area larger
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.layer.backgroundColor = UIColor.init(white: 0.0, alpha: 0.3).cgColor
            indicator.center = window.center
            indicator.hidesWhenStopped = true
            window.addSubview(indicator)
            window.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subview]|",
                options: [], metrics: nil, views: ["subview":indicator]))
            window.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subview]|",
                options: [], metrics: nil, views: ["subview":indicator]))
            indicator.startAnimating()
            return indicator
        }
        
    }
    
    @discardableResult
    open static func startGiftFullScreenLoadingIndicator() -> FLAnimatedImageView {
        let window = UIApplication.shared.delegate!.window!!
        if let indicator = window.viewWithTag(FULL_SCREEN_LOADING_VIEW_TAG) as? FLAnimatedImageView {
            // loading indicator is already on screen
            return indicator
        } else {
            
            
            // bg layer
            let mainView = UIView()
            mainView.tag = FULL_SCREEN_LOADING_VIEW_TAG
            mainView.backgroundColor = UIColor.init(white: 1.0, alpha: 0.9)
            mainView.translatesAutoresizingMaskIntoConstraints = false
            window.addSubview(mainView)
            window.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subview]|",
                options: [], metrics: nil, views: ["subview":mainView]))
            window.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subview]|",
                options: [], metrics: nil, views: ["subview":mainView]))
            
            // gif image as loading indicator
            let image = FLAnimatedImage(animatedGIFData: DTLoadingIndicator.loadingImageData)
            let imageView = FLAnimatedImageView()
            imageView.animatedImage = image
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            mainView.addSubview(imageView)
            imageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[subview(60)]",
                options: [], metrics: nil, views: ["subview":imageView]))
            imageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[subview(60)]",
                options: [], metrics: nil, views: ["subview":imageView]))
            mainView.addConstraint(NSLayoutConstraint(item: mainView, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerX, multiplier: 1, constant: 0))
            mainView.addConstraint(NSLayoutConstraint(item: mainView, attribute: .centerY, relatedBy: .equal, toItem: imageView, attribute: .centerY, multiplier: 1, constant: 0))
            
            
            return imageView
        }
        
    }

    
    open static func stopFullScreenLoadingIndicator() {
        let view = UIApplication.shared.delegate!.window!!
        if let indicator = view.viewWithTag(FULL_SCREEN_LOADING_VIEW_TAG) {
            indicator.removeFromSuperview()
        }
    }
    
    @discardableResult
    open static func startLoadingIndicatorInView(_ view:UIView, verticalCenter:Bool = false, top:CGFloat = 0) -> UIActivityIndicatorView {
        if let indicator = view.viewWithTag(IN_VIEW_LOADING_VIEW_TAG) as? UIActivityIndicatorView {
            // loading indicator is already in the view
            return indicator
        } else {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            indicator.hidesWhenStopped = true
            indicator.tag = IN_VIEW_LOADING_VIEW_TAG
            indicator.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(indicator)
            if verticalCenter {
                view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: indicator, attribute: .centerY, multiplier: 1, constant: 0))
            } else {
                view.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: indicator, attribute: .top, multiplier: 1, constant: -top))
            }
            
            view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: indicator, attribute: .centerX, multiplier: 1, constant: 0))
            indicator.startAnimating()
            return indicator
        }
        
    }

    @discardableResult
    open static func startGiftLoadingIndicatorInView(_ view:UIView, verticalCenter:Bool = false, top:CGFloat = 0) -> FLAnimatedImageView {
        if let indicator = view.viewWithTag(IN_VIEW_LOADING_VIEW_TAG) as? FLAnimatedImageView {
            // loading indicator is already in the view
            return indicator
        } else {
            let image = FLAnimatedImage(animatedGIFData: DTLoadingIndicator.loadingImageData)
            let imageView = FLAnimatedImageView()
            imageView.animatedImage = image
            imageView.contentMode = .scaleAspectFit
            imageView.tag = IN_VIEW_LOADING_VIEW_TAG
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            if verticalCenter {
                view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: imageView, attribute: .centerY, multiplier: 1, constant: 0))
                
            } else {
                view.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .top, multiplier: 1, constant: -top))
            }

            imageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[subview(40)]",
                options: [], metrics: nil, views: ["subview":imageView]))
            imageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[subview(40)]",
                                                                    options: [], metrics: nil, views: ["subview":imageView]))
            view.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerX, multiplier: 1, constant: 0))

            return imageView
        }
        
    }
    
    open static func stopLoadingIndicatorInView(_ view: UIView) {
        if let indicator = view.viewWithTag(IN_VIEW_LOADING_VIEW_TAG) {
            indicator.removeFromSuperview()
        }
    }

}
