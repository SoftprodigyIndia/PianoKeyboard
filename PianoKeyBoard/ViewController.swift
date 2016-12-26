//
//  ViewController.swift
//  PianoKeyBoard
//
//  Created by Ramesh on 20/09/16.
//  Copyright © 2016 Ramesh. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController,KeyboardViewDelegate {

    var keyBoardScrollView: UIScrollView!
    var arrayOfBlackKeys: [Int] = [ -1, -1, 2, -1, 4, -1, -1, 7, -1, 9, -1, -1, 12, -1, 14, -1, -1,-1]
    var keysArray : NSMutableArray = []
    var audioArray : NSMutableArray = []
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "keyboardLayout", ofType: "plist")
        let names = NSArray(contentsOfFile: plistPath!)
        
        let blackKeysArray : NSMutableArray = []
        let whiteKeysArray : NSMutableArray = []
        let combineKeysArray : NSMutableArray = []
        
        for i in 8 ..< 52 {
            let strName = names?.object(at: i)
            if ((strName! as AnyObject).hasSuffix("s")) {
                blackKeysArray.add((names?.object(at: i))!)
            } else {
                whiteKeysArray.add((names?.object(at: i))!)
            }
        }
        
        combineKeysArray.addObjects(from: whiteKeysArray as [AnyObject])
        combineKeysArray.addObjects(from: blackKeysArray as [AnyObject])
        
        for i in 0 ..< combineKeysArray.count {
            var soundID : SystemSoundID = 0
            let path = Bundle.main.path(forResource: (combineKeysArray[i] as! String), ofType: "aif")
            AudioServicesCreateSystemSoundID(URL(fileURLWithPath:path!) as CFURL, &soundID)
            let audioId = NSNumber(value: soundID as UInt32)
            audioArray.add(audioId)
        }
        
        self.createKeyboard()  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Create Piano Keyboard
    
    func createKeyboard() {
        keyBoardScrollView = UIScrollView()
        keyBoardScrollView.frame = CGRect(x: 0, y: self.view.frame.size.height-200, width: self.view.frame.size.width, height: 150)
        self.view.addSubview(keyBoardScrollView)
        let keyBoard = KeyBoardView()
        keyBoard.delegate = self
        keyBoard.frame = CGRect(x: 0, y: 0, width: 624, height: 150)
        keyBoardScrollView.isScrollEnabled = true
        keyBoardScrollView.addSubview(keyBoard)
        keyBoardScrollView.contentSize = CGSize(width: 624, height: 150)
    }

    // MARK: - Piano Keyboard Delegate Method

    func keysPressed(_ ary: NSMutableArray) {
        let key : BaseKey = ary.lastObject as! BaseKey;
        let imgTag = key.tag-100
        if audioArray.count > imgTag {
            let rating: NSNumber = audioArray[imgTag] as! NSNumber
            let x : Int = rating.intValue
            let x32 = Int32(x)
            let xu32 = UInt32(x32)
            let soundID : SystemSoundID = xu32
            AudioServicesPlaySystemSound(soundID)
        }
    }
}

