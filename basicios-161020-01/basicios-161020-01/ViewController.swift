//
//  ViewController.swift
//  basicios-161020-01
//
//  Created by Cam Loan on 10/20/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func txtCheckingNgayThang(_ sender: AnyObject) {
        if (txtDate.text?.characters.count == 10){
            txtDate.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            btnCheckingCalc.isHidden = false
        } else {
            txtDate.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            btnCheckingCalc.isHidden = true
        }
    }
    
    @IBOutlet var btnCheckingCalc: UIButton!
    @IBOutlet var lblResult: UILabel!
    @IBOutlet var txtDate: UITextField!
    @IBAction func abtnCalc(_ sender: UIButton) {
        let ngaythang: String = txtDate.text!
        
        let kiemtra_ngaythang = Kiem_Tra_NgayThang(ngaythang: ngaythang)
        if let kiemtra_ngaythang = kiemtra_ngaythang {
            let iNgay:Int = kiemtra_ngaythang[0]
            let iThang:Int = kiemtra_ngaythang[1]
            let iNam:Int = kiemtra_ngaythang[2]
            if  ngayThangHopLy(ngay: iNgay, thang: iThang, nam: iNam)  != nil {
            let thu:String = Ngay_Trong_Tuan(iDay: iNgay, iMonth: iThang, iYear: iNam)
            lblResult.text = thu
            }else{
                    lblResult.text = "Format Invalid"
            }
        }else{
            lblResult.text = "Format Invalid"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnCheckingCalc.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func ngayThangHopLy(ngay:Int,thang: Int, nam: Int) -> [Int]? {
        if nam > 0  && thang > 0 && thang < 13  && ngay  > 0 {
            switch thang {
            case 1,3,5,7,8,10,12:
                if  ngay < 32 {
                    return [ngay, thang, nam]
                }else{
                    return nil
                }
            case 4,6,9,11:
                if   ngay < 31 {
                    return [ngay, thang, nam]
                }else{
                    return nil
                }
            default:
                if nam % 400 == 0 || (nam % 4 == 0 && nam % 100 != 0) {
                    if  ngay < 30 {
                        return [ngay, thang, nam]
                    }else{
                        return nil
                    }
                }else{
                    if ngay < 29 {
                        return [ngay, thang, nam]
                    }else{
                        return nil
                    }
                }
            }
        } else {
            return nil
        }
    }
    func Kiem_Tra_NgayThang(ngaythang: String) ->  [Int]? {
        let arrNgayThang: Array<String> = ngaythang.components(separatedBy: "/")
        if arrNgayThang.count != 3 {
            return nil
        } else {
            if let iNgay:Int = Int(arrNgayThang[0]),  let iThang:Int = Int(arrNgayThang[1]), let iNam:Int = Int(arrNgayThang[2]) {
                print(iNgay, iThang, iNam)
                
                return [iNgay, iThang, iNam]
            } else {
                return nil
            }
        }
    }
    
    func Tong_So_Ngay(iDay:Int,iMonth:Int,iYear:Int)-> Int {
        var sumdays: Int=0
        let arrNormalMonth:Array<Int>=[31,28,31,30,31,30,31,31,30,31,30,31]
        let arrLeapMonth:Array<Int>=[31,29,31,30,31,30,31,31,30,31,30,31]
        
        if (iYear % 4 == 0) {
            for i in 1 ..< iMonth {
                sumdays += arrLeapMonth[i]
            }
            sumdays += iDay
        } else {
            for i in 1 ..< iMonth {
                sumdays += arrNormalMonth[i]
            }
            sumdays += iDay
        }
        return sumdays
    }
    
    func Ngay_Trong_Tuan(iDay:Int,iMonth:Int,iYear:Int) -> String {
        var thu:String=""
        let dicThu:Dictionary<Int,String> =  [0:"Chủ Nhật",1:"Thứ Hai", 2:"Thứ Ba",3:"Thứ Tư", 4:"Thứ Năm", 5:"Thứ Sáu",6:"Thứ Bảy"]
        let tong_ngay = Tong_So_Ngay(iDay: iDay, iMonth: iMonth, iYear: iYear)
        let ret = (((iYear - 1) + (iYear - 1)/4 - (iYear - 1)/100 + (iYear - 1)/400) + tong_ngay) % 7
        for (key,value) in dicThu {
            if (key == ret) {
                thu = value
            }
        }
        return thu
    }

}

