//
//  ViewController.swift
//  HuiTuDemo
//
//  Created by Win10 on 2017/6/29.
//  Copyright © 2017年 Win10. All rights reserved.
//    http://www.jianshu.com/p/3e2cca585ccc

import UIKit

let YHScreenWidth : CGFloat = UIScreen.main.bounds.width
let YHScreenHeight : CGFloat = UIScreen.main.bounds.height


class ViewController: UIViewController {

    
    @IBOutlet weak var onImageView: UIImageView!
   
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
      let inputimage = CIImage.init(image:UIImage(named:"demo")!)
      
      let filter2 =  CIFilter.init(name:"CIPerspectiveTransform")
      
      
      let width = YHScreenWidth - 60
      let height = YHScreenHeight - 64 - 64
      
      
      filter2?.setDefaults()
      filter2?.setValue(inputimage,forKey: "inputImage")
      filter2?.setValue(CIVector.init(x: 0, y: height), forKey: "inputTopLeft")
      filter2?.setValue(CIVector.init(x: width, y: height), forKey: "inputTopRight")
      filter2?.setValue(CIVector.init(x: 0, y: 0), forKey: "inputBottomLeft")
      filter2?.setValue(CIVector.init(x: width, y: 0), forKey: "inputBottomRight")
      
      
      
      

      
      
      
      
      
      
      func callbackdemo(_ lefttop:CGPoint,
                        _ righttop:CGPoint,
                        _ leftbottom:CGPoint,
                        _ rightbottom:CGPoint) -> Void {
         
         filter2?.setValue(CIVector.init(x: lefttop.x, y: height - lefttop.y), forKey: "inputTopLeft")
         filter2?.setValue(CIVector.init(x: righttop.x, y: height - righttop.y), forKey: "inputTopRight")

         filter2?.setValue(CIVector.init(x: leftbottom.x, y: height - leftbottom.y), forKey: "inputBottomLeft")
         filter2?.setValue(CIVector.init(x: rightbottom.x, y: height - rightbottom.y), forKey: "inputBottomRight")
         
         
         let oImg = UIImage(ciImage:(filter2?.outputImage)!)
         
         
         UIGraphicsBeginImageContextWithOptions(CGSize(width:width,height:height), false, 0);
//         let con = UIGraphicsGetCurrentContext();

         let xs = [lefttop.x,righttop.x,leftbottom.x,rightbottom.x]
         let minx = xs.min()
         
         let ys = [lefttop.y,righttop.y,leftbottom.y,rightbottom.y]
         let miny = ys.min()
         
         oImg.draw(at: CGPoint(x:minx!,y:miny!))
         
         let im = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
         
         
         
         onImageView.image = im;
      }
      
      
      
      
      let v = DrawView(frame:CGRect(x:30,y:64,width:width,height:height))
      self.view.addSubview(v)
      v.callback = callbackdemo
      
      
      
    }
   
      
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

