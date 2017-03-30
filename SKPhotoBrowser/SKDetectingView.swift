//
//  SKDetectingView.swift
//  SKPhotoBrowser
//
//  Created by suzuki_keishi on 2015/10/01.
//  Copyright © 2015 suzuki_keishi. All rights reserved.
//

import UIKit

@objc protocol SKDetectingViewDelegate {
    func handleSingleTap(_ view: UIView, touchPoint: CGPoint)
    func handleDoubleTap(_ view: UIView, touchPoint: CGPoint)
}

class SKDetectingView: UIView {

    weak var delegate: SKDetectingViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func handleSingleTap(_ recognizer: UITapGestureRecognizer) {
        delegate?.handleSingleTap(self, touchPoint: recognizer.location(in: self))
    }
    
    func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        delegate?.handleDoubleTap(self, touchPoint: recognizer.location(in: self))
    }
}

private extension SKDetectingView {
    func setup() {
        isUserInteractionEnabled = true

        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_:)))
        singleTap.require(toFail: doubleTap)
        addGestureRecognizer(singleTap)
    }
}
