//
//  DrawView.swift
//  HuiTuDemo
//
//  Created by junlei on 2017/6/29.
//  Copyright © 2017年 Win10. All rights reserved.
//

import UIKit


func dragViewCreat() -> UIView {
    let v = UIView()
    v.backgroundColor = UIColor.blue
    let length = 15
    v.frame = CGRect(x:0,y:0,width:length,height:length)
    v.layer.cornerRadius = 4.0
    return v
}

func callbackdemo(_ lefttop:CGPoint,
                  _ righttop:CGPoint,
                  _ leftbottom:CGPoint,
                  _ rightbottom:CGPoint) -> Void {
    
}


class DrawView: UIView {
    
    open var callback:(_ lefttop:CGPoint,
                        _ righttop:CGPoint,
                        _ leftbottom:CGPoint,
        _ rightbottom:CGPoint)->Void? = callbackdemo
    
    
    var currentView : UIView?
    
    let lefttop : UIView = dragViewCreat()
    let righttop : UIView = dragViewCreat()
    let leftbottom : UIView = dragViewCreat()
    let rightbottom : UIView = dragViewCreat()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lefttop.center = CGPoint(x:0,y:0)
        righttop.center = CGPoint(x:frame.size.width,y:0)
        leftbottom.center = CGPoint(x:0,y:frame.size.height)
        rightbottom.center = CGPoint(x:frame.size.width,y:frame.size.height)
        
        self.addSubview(lefttop)
        self.addSubview(righttop)
        self.addSubview(leftbottom)
        self.addSubview(rightbottom)
        
        self.backgroundColor = UIColor.clear
    
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        let a = [lefttop,righttop,leftbottom,rightbottom]
        let currentPoint = touches.first?.location(in: self);
        currentView = nil;
        for v in a {
            if v.frame.contains(currentPoint!) {
                currentView = v
                break;
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let currentPoint = touches.first?.location(in: self);
        currentView?.center = currentPoint!;
        
        self.setNeedsDisplay()
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        callback(lefttop.center,righttop.center,leftbottom.center,rightbottom.center)
        
        self.setNeedsDisplay()
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath()
        path.move(to: lefttop.center)
        path.addLine(to: righttop.center)
        path.addLine(to: rightbottom.center)
        path.addLine(to: leftbottom.center)
        path.close()
        
        UIColor.blue.setStroke()
        // 将path绘制出来
        path.stroke()
    }
    
    
}
