//
//  KeyBoardScrollView.swift
//  PianoKeyBoard
//
//  Created by Ramesh on 21/09/16.
//  Copyright © 2016 Ramesh. All rights reserved.
//

import UIKit

class KeyBoardScrollView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UItouch delegate Methods

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            print(currentPoint)
            // do something with your currentPoint
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            print(currentPoint)
            // do something with your currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            print(currentPoint)
            // do something with your currentPoint
        }
    }

}
