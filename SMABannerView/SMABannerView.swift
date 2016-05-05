//
//  SMABannerView.swift
//
//  Created by Bill Burgess on 5/4/16.
//  Copyright © 2016 Simply Made Apps. All rights reserved.
//

import UIKit

enum SMABannerAlignment: Int {
    case Center = 0
    case Left   = 1
    case Right  = 2
}

class SMABannerView: UIView {
    private var bottomConstraint: NSLayoutConstraint?
    
    var titleLabel: UILabel?
    var messageLabel: UILabel?
    var titleString: String?
    var messageString: String?
    
    var containerView: UIView?
    var titleFont = UIFont.systemFontOfSize(24)
    var titleColor = UIColor.blackColor()
    var messageFont = UIFont.systemFontOfSize(18)
    var messageColor = UIColor.blackColor()
    var animationDuration = 0.3
    var titlePaddingTop: CGFloat = 15.0
    var paddingLeft: CGFloat = 40.0
    var paddingRight: CGFloat = 40.0
    var messagePaddingBottom: CGFloat = 10.0
    var opacity: CGFloat = 0.8
    var bannerHeight: CGFloat = 100.0
    
    var alignment: SMABannerAlignment
    
    var isShowing: Bool
    var isAnimating: Bool
    
    required init?(coder: NSCoder) {
        isShowing = false
        isAnimating = false
        alignment = .Center
        
        super.init(coder: coder)
    }
    
    init() {
        isShowing = false
        isAnimating = false
        alignment = .Center
        
        super.init(frame: CGRectZero)
    }
    
    convenience init(title: String?, message: String?, view: UIView) {
        self.init()
        
        self.containerView = view
        self.titleString = title
        self.messageString = message
    }
    
    func layoutBannerView() {
        titleLabel = UILabel.init()
        titleLabel?.numberOfLines = 1
        titleLabel?.text = titleString
        titleLabel?.font = self.titleFont
        titleLabel?.textColor = titleColor
        titleLabel?.adjustsFontSizeToFitWidth = true
        messageLabel = UILabel.init()
        messageLabel?.numberOfLines = 0
        messageLabel?.text = messageString
        messageLabel?.font = messageFont
        messageLabel?.textColor = messageColor
        messageLabel?.adjustsFontSizeToFitWidth = true
        messageLabel?.lineBreakMode = .ByTruncatingTail
        
        switch alignment {
        case .Left:
            titleLabel?.textAlignment = .Left
            messageLabel?.textAlignment = .Left
        case .Right:
            titleLabel?.textAlignment = .Right
            messageLabel?.textAlignment = .Right
        case .Center:
            titleLabel?.textAlignment = .Center
            messageLabel?.textAlignment = .Center
        }
        
        self.addSubview(titleLabel!)
        self.addSubview(messageLabel!)
        
        self.containerView?.addSubview(self)
        
        self.alpha = self.opacity
        
        // constraints
        
        // view
        self.translatesAutoresizingMaskIntoConstraints = false
        bottomConstraint = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: self.containerView, attribute: .Bottom, multiplier: 1.0, constant: bannerHeight)
        self.containerView!.addConstraint(bottomConstraint!)
        let viewLeft = NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: self.containerView, attribute: .Left, multiplier: 1.0, constant: 0)
        self.containerView!.addConstraint(viewLeft)
        let viewRight = NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: self.containerView, attribute: .Right, multiplier: 1.0, constant: 0)
        self.containerView!.addConstraint(viewRight)
        let viewHeight = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: bannerHeight)
        self.containerView!.addConstraint(viewHeight)
        
        // title
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        let titleTop = NSLayoutConstraint(item: titleLabel!, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: titlePaddingTop)
        self.addConstraint(titleTop)
        let titleLeft = NSLayoutConstraint(item: titleLabel!, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: paddingLeft)
        self.addConstraint(titleLeft)
        let titleRight = NSLayoutConstraint(item: titleLabel!, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: -paddingRight)
        self.addConstraint(titleRight)
        
        // message
        messageLabel?.translatesAutoresizingMaskIntoConstraints = false
        let messageTop = NSLayoutConstraint(item: messageLabel!, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1.0, constant: 0)
        self.addConstraint(messageTop)
        let messageLeft = NSLayoutConstraint(item: messageLabel!, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: paddingLeft)
        self.addConstraint(messageLeft)
        let messageRight = NSLayoutConstraint(item: messageLabel!, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: -paddingRight)
        self.addConstraint(messageRight)
        let messageBottom = NSLayoutConstraint(item: messageLabel!, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: -messagePaddingBottom)
        self.addConstraint(messageBottom)
        
        self.layoutIfNeeded()
    }

    func show() {
        if self.isShowing || self.isAnimating {
            print("Unable to present Banner View: Currently showing or animating")
            return
        }
        
        if self.containerView != nil {
            self.layoutBannerView()
            self.isAnimating = true
            self.containerView!.removeConstraint(bottomConstraint!)
            bottomConstraint = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: self.containerView, attribute: .Bottom, multiplier: 1.0, constant: 0)
            self.containerView!.addConstraint(bottomConstraint!)
            UIView.animateWithDuration(self.animationDuration, animations: {
                self.layoutIfNeeded()
                }, completion: { (complete) in
                    self.isShowing = true
                    self.isAnimating = false
            })
        }
    }
    
    func show(duration: Double) {
        self.show()
        let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(duration * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.hide(nil)
        })
    }
    
    func show(duration: Double, completion:(() -> Void)) {
        self.show()
        let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(duration * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.hide(completion)
        })
    }
    
    func hide(completion:((Void) -> ())?) {
        if self.isAnimating || !self.isShowing {
            print("Unable to dismiss Banner View: Currently animating or not showing")
            if completion != nil {
                completion!()
            }
            return
        }
        
        if self.containerView != nil {
            self.isAnimating = true
            self.containerView!.removeConstraint(bottomConstraint!)
            bottomConstraint = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: self.containerView, attribute: .Bottom, multiplier: 1.0, constant: bannerHeight)
            self.containerView!.addConstraint(bottomConstraint!)
            UIView.animateWithDuration(self.animationDuration, animations: {
                // animations
                self.layoutIfNeeded()
                }, completion: { (complete) in
                    self.isAnimating = false
                    self.isShowing = false
                    self.removeFromSuperview()
                    if completion != nil {
                        completion!()
                    }
            })
        } else {
            print("Unable to hide Banner View: No container view")
            if completion != nil {
                completion!()
            }
        }
    }
    
    func hide() {
        self.hide(nil)
    }
}
