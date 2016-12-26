//
//  KeyBoardView.swift
//  PianoKeyBoard
//
//  Created by Ramesh on 21/09/16.
//  Copyright © 2016 Ramesh. All rights reserved.
//

import UIKit

protocol KeyboardViewDelegate {
    func keysPressed(_ ary:NSMutableArray)
}

class KeyBoardView: UIView {
    
    var delegate:KeyboardViewDelegate?
    
    var arrayOfBlackKeys: [Int] = [ -1, -1, 2, -1, 4, -1, -1, 7, -1, 9, -1, -1, 12, -1, 14, -1, -1,-1]
    var keysArray: [BaseKey] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createKeyboard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Create Piano Keyboard

    func createKeyboard() {
        for i in 0..<26 {
            let keyWhite = WhiteKey(frame: CGRect(x: i*24, y: 0, width: 24, height: 150))
            keyWhite.tag = 100+i
            keyWhite.keyId = 100+i
            keyWhite.image = UIImage(named: "ivory_keyup")
            keyWhite.highlightedImage = UIImage(named: "ivory_keydown")
            keyWhite.isHighlighted = false
            keyWhite.isUserInteractionEnabled = false
            self.addSubview(keyWhite)
            keysArray.append(keyWhite)
        }
        
        var aXies = 14
        
        for var i in 26..<44 {
            let keyBlack = BlackKey(frame: CGRect(x: aXies, y: 0, width: 20, height: 90))
            keyBlack.tag = 100+i
            keyBlack.keyId = 100+i
            keyBlack.image = UIImage(named: "ebony_keyup2")
            keyBlack.highlightedImage = UIImage(named: "ebony_keydown2")
            keyBlack.isHighlighted = false
            keyBlack.isUserInteractionEnabled = false
            self.addSubview(keyBlack)
            keysArray.append(keyBlack)
            i = i - 26
            if (i == arrayOfBlackKeys[i]) {
                if i != 0 {
                    aXies = aXies+24
                }
            }
            aXies = aXies+24
        }
    }
    
    // MARK: - UItouch delegate Methods

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesMoved(touches, with: event)
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            print(currentPoint)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            let pressedKeys : NSMutableArray = []
            for keyIndex in 0 ..< keysArray.count {
                let key : BaseKey = keysArray[keyIndex];
                var keyIsPressed = false;
                for touch in touches {
                    let location = touch.location(in: self)
                     if(key.frame.contains(location)) {
                        var ignore = false
                        if (key .isKind(of: WhiteKey.self)) {
                            if (keyIndex > 0) {
                                let previousKey : BaseKey = keysArray[keyIndex-1];
                                if(previousKey.isKind(of: BlackKey.self) && previousKey.frame.contains(location)) {
                                    ignore = true;
                                }
                            }
                            
                            if (keyIndex < keysArray.count-1) {
                                let nextKey : BaseKey = keysArray[keyIndex+1];
                                if (nextKey .isKind(of: BlackKey.self)) {
                                    if(nextKey.frame.contains(location)) {
                                        ignore = true;
                                    }
                                }
                            }
                        }
                        
                        if (ignore == false) {
                            keyIsPressed = true;
                            if (key.isHighlighted == false){
                                key.isHighlighted = true;
                                if (delegate != nil) {
                                    pressedKeys.add(key)
                                }
                            }
                        }
                    }
                }
                
                if (keyIsPressed == false && key.isHighlighted == true) {
                    key.isHighlighted = false;
                }
            }
        if (delegate != nil && pressedKeys.count > 0) {
            delegate?.keysPressed(pressedKeys)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            for key in keysArray {
                if(key.frame.contains(currentPoint)) {
                    if (touch.phase == UITouchPhase.ended || touch.phase == UITouchPhase.cancelled) {
                        key.isHighlighted = false
                    } else {
                        print("Unhandled touch phase:\(touch.phase)")
                    }
                }
            }
        }
    }
    
}
