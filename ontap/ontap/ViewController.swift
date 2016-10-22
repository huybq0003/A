//
//  ViewController.swift
//  ontap
//
//  Created by Cam Loan on 10/19/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    func Tong_So_Ngay(iDay:Int,iMonth:Int,iYear:Int)-> Int
    {
        var sumdays: Int=0
        let arrNormalMonth:Array<Int>=[31,28,31,30,31,30,31,31,30,31,30,31]
        let arrLeapMonth:Array<Int>=[31,29,31,30,31,30,31,31,30,31,30,31]
        
        if (iYear%4 == 0)
        {
            //Month289 = 29
            for i in 1 ..< iMonth
            {
                sumdays += arrLeapMonth[i]
            }
            sumdays += iDay
        }
        else
        {
            //Month289 = 28
            for i in 1 ..< iMonth
            {
                sumdays += arrNormalMonth[i]
            }
            sumdays += iDay
        }
        return sumdays
    }
    func Ngay_Trong_Tuan(iDay:Int,iMonth:Int,iYear:Int) -> String
    {
        var thu:String=""
        let dicThu:Dictionary<Int,String> =  [0:"Chu Nhat",1:"Thu Hai", 2:"Thu Ba",3:"Thu Tu", 4:"Thu Nam", 5:"Thu Sau",6:"Thu Bay"]
        let tong_ngay = Tong_So_Ngay(iDay: iDay, iMonth: iMonth, iYear: iYear)
        let ret = (((iYear - 1) + (iYear - 1)/4 - (iYear - 1)/100 + (iYear - 1)/400) + tong_ngay) % 7
        
        for (key,value) in dicThu
        {
            if (key == ret)
            {
                thu = value
                
            }
        }
        return thu
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let thu = Ngay_Trong_Tuan(iDay: 19, iMonth: 1, iYear: 1900)
        print (thu)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

