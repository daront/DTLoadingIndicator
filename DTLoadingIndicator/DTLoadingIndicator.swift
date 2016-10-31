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

public class DTLoadingIndicator {
    
    static let IN_VIEW_LOADING_VIEW_TAG = 98
    static let FULL_SCREEN_LOADING_VIEW_TAG = 99
    static var fullScreenPendingTaskCount = 0
    static var loadingImageName = "love.gif"
    
    static var loadingImageData: NSData {
        let frameworkBundle = NSBundle(forClass: DTLoadingIndicator.self)
        let resourcePath = frameworkBundle.pathForResource(loadingImageName, ofType: nil)
        return NSData(contentsOfFile: resourcePath!)!;
    }
    
    public static func startFullScreenLoadingIndicator() -> UIActivityIndicatorView {
        let window = UIApplication.sharedApplication().delegate!.window!!
        if let indicator = window.viewWithTag(FULL_SCREEN_LOADING_VIEW_TAG) as? UIActivityIndicatorView {
            // loading indicator is already on screen
            return indicator
        } else {
            // loading indicator isn't on screen yet -> create one
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
            indicator.tag = FULL_SCREEN_LOADING_VIEW_TAG
            
            // make the area larger
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.layer.backgroundColor = UIColor.init(white: 0.0, alpha: 0.3).CGColor
            indicator.center = window.center
            indicator.hidesWhenStopped = true
            window.addSubview(indicator)
            window.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subview]|",
                options: [], metrics: nil, views: ["subview":indicator]))
            window.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subview]|",
                options: [], metrics: nil, views: ["subview":indicator]))
            indicator.startAnimating()
            return indicator
        }
        
    }
    
    public static func startGiftFullScreenLoadingIndicator() -> FLAnimatedImageView {
        let window = UIApplication.sharedApplication().delegate!.window!!
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
            window.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subview]|",
                options: [], metrics: nil, views: ["subview":mainView]))
            window.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subview]|",
                options: [], metrics: nil, views: ["subview":mainView]))
            
            // gif image as loading indicator
            let image = FLAnimatedImage(animatedGIFData: DTLoadingIndicator.loadingImageData)
            let imageView = FLAnimatedImageView()
            imageView.animatedImage = image
            imageView.contentMode = .ScaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            mainView.addSubview(imageView)
            imageView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[subview(60)]",
                options: [], metrics: nil, views: ["subview":imageView]))
            imageView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[subview(60)]",
                options: [], metrics: nil, views: ["subview":imageView]))
            mainView.addConstraint(NSLayoutConstraint(item: mainView, attribute: .CenterX, relatedBy: .Equal, toItem: imageView, attribute: .CenterX, multiplier: 1, constant: 0))
            mainView.addConstraint(NSLayoutConstraint(item: mainView, attribute: .CenterY, relatedBy: .Equal, toItem: imageView, attribute: .CenterY, multiplier: 1, constant: 0))
            
            
            return imageView
        }
        
    }

    
    public static func stopFullScreenLoadingIndicator() {
        let view = UIApplication.sharedApplication().delegate!.window!!
        if let indicator = view.viewWithTag(FULL_SCREEN_LOADING_VIEW_TAG) {
            indicator.removeFromSuperview()
        }
    }
    
    public static func startLoadingIndicatorInView(view:UIView, verticalCenter:Bool = false, top:CGFloat = 0) -> UIActivityIndicatorView {
        if let indicator = view.viewWithTag(IN_VIEW_LOADING_VIEW_TAG) as? UIActivityIndicatorView {
            // loading indicator is already in the view
            return indicator
        } else {
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
            indicator.hidesWhenStopped = true
            indicator.tag = IN_VIEW_LOADING_VIEW_TAG
            indicator.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(indicator)
            if verticalCenter {
                view.addConstraint(NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: indicator, attribute: .CenterY, multiplier: 1, constant: 0))
            } else {
                view.addConstraint(NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: indicator, attribute: .Top, multiplier: 1, constant: -top))
            }
            
            view.addConstraint(NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: indicator, attribute: .CenterX, multiplier: 1, constant: 0))
            indicator.startAnimating()
            return indicator
        }
        
    }

    
    public static func startGiftLoadingIndicatorInView(view:UIView, verticalCenter:Bool = false, top:CGFloat = 0) -> FLAnimatedImageView {
        if let indicator = view.viewWithTag(IN_VIEW_LOADING_VIEW_TAG) as? FLAnimatedImageView {
            // loading indicator is already in the view
            return indicator
        } else {
            let image = FLAnimatedImage(animatedGIFData: DTLoadingIndicator.loadingImageData)
            let imageView = FLAnimatedImageView()
            imageView.animatedImage = image
            imageView.contentMode = .ScaleAspectFit
            imageView.tag = IN_VIEW_LOADING_VIEW_TAG
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            if verticalCenter {
                view.addConstraint(NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: imageView, attribute: .CenterY, multiplier: 1, constant: 0))
                
            } else {
                view.addConstraint(NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: imageView, attribute: .Top, multiplier: 1, constant: -top))
            }

            imageView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[subview(40)]",
                options: [], metrics: nil, views: ["subview":imageView]))
            view.addConstraint(NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: imageView, attribute: .CenterX, multiplier: 1, constant: 0))

            return imageView
        }
        
    }
    
    public static func stopLoadingIndicatorInView(view: UIView) {
        if let indicator = view.viewWithTag(IN_VIEW_LOADING_VIEW_TAG) {
            indicator.removeFromSuperview()
        }
    }

}