//
//  ViewController.swift
//  calculator
//
//  Created by John on 27/10/2019.
//  Copyright © 2019 John. All rights reserved.
//

import UIKit

//extension Double {
//    var clean: Double {
//        return Double(self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.1f", self) : String(self))!
//    }
//    var formattedWithSeparator: String {
//        return Formatter.withSeparator.string(for: self) ?? ""
//    }
//}
//
//extension Formatter {
//    static let withSeparator: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.groupingSeparator = ","
//        formatter.numberStyle = .decimal
//        return formatter
//    }()
//}



class ViewController: UIViewController {


    @IBOutlet weak var process: UILabel!
    @IBOutlet weak var result: UILabel!
    
    var math:String = ""
    var tempNum:String = ""
    var lastResult:Double = 0.0
    var startOver = true
    var firstNum = ""
    var secondNum = ""
    var firstNumChar:Int = 0
    var secondNumChar:Int = 0
    var isFirstNum = true
    var sign = ""
    var inResult = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        process.text = ""
        firstNum = result.text!
        result.adjustsFontSizeToFitWidth = true
        //result.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        //result.adjustsFontForContentSizeCategory = true

        
    }

    
    
    func input(input:String) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        plusCircle.tintColor = UIColor.systemOrange
        plusSign.tintColor = UIColor.white
        minusCircle.tintColor = UIColor.systemOrange
        minusSign.tintColor = UIColor.white
        multiplyCircle.tintColor = UIColor.systemOrange
        multiplySign.tintColor = UIColor.white
        divideCircle.tintColor = UIColor.systemOrange
        divideSign.tintColor = UIColor.white
        print(input)
        
        print("inresult: \(inResult), startover: \(startOver), isFirst: \(isFirstNum)")
        if inResult {
            isFirstNum = true
        }
        if startOver && input != "." {
            result.text = String(input)
            startOver = false
            
            if isFirstNum {
                firstNum = input
                firstNumChar += 1
                
            }
            else {
                secondNum = input
                secondNumChar += 1
            }
        }
        else {
            
            if isFirstNum {
                if (input != "." || !firstNum.contains(".")) && firstNumChar < 9{
                    result.text = numberFormatter.string(for: Double(firstNum + input))
                    firstNum = firstNum + input
                    firstNumChar += 1
                }
            }
            else {
                if (input != "." || !secondNum.contains(".")) && secondNumChar < 9 {
                    result.text = numberFormatter.string(for: Double(secondNum + input))
                    secondNum = secondNum + input
                    secondNumChar += 1
                }
            }
            startOver = false
        }
        print("math: [\(firstNum)] [\(sign)] [\(secondNum)]")
    }
    
    func calculate(operatorSign:String) {
        print("input: \(operatorSign)")
        if isFirstNum && sign == "" {
            isFirstNum = false
            sign = operatorSign
            inResult = false
        }
        else if !isFirstNum && secondNum == "" && operatorSign != "=" {
            sign = operatorSign
            inResult = false
        }
        else {
            if !firstNum.contains(".") {
                firstNum = firstNum + ".0"
            }
            if secondNum != "" {
                if !secondNum.contains(".") {
                    secondNum = secondNum + ".0"
                }
                
            }
            else {
                sign = ""
            }
            math = firstNum + sign + secondNum
            let expn = NSExpression(format:math)
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            result.text = numberFormatter.string(for: expn.expressionValue(with: nil, context: nil) as? Double ?? 0)
            print(result.text!)
//            let nsString = result.text! as NSString
//            if nsString.length >= 9
//            {
//                result.text = nsString.substring(with: NSRange(location: 0, length: nsString.length > 9 ? 9 : nsString.length))
//            }
            
            
//            if result.text!.suffix(2) == ".0" {
//                result.text!.remove(at: result.text!.index(before: result.text!.endIndex))
//                result.text!.remove(at: result.text!.index(before: result.text!.endIndex))
//            }
            firstNum = String(expn.expressionValue(with: nil, context: nil) as? Double ?? 0)
            firstNumChar = firstNum.count
            secondNum = ""
            secondNumChar = 0
            math = ""
            if !(operatorSign == "=") {
                sign = operatorSign
            }
            else {
                sign = ""
                inResult = true
            }
        }
        startOver = true
        print("math: [\(firstNum)] [\(sign)] [\(secondNum)]")
    }
    
    @IBAction func button1(_ sender: Any) {
        input(input:"1")
    }
    @IBAction func button2(_ sender: Any) {
        input(input:"2")
    }
    @IBAction func button3(_ sender: Any) {
        input(input:"3")
    }
    @IBAction func button4(_ sender: Any) {
        input(input:"4")
    }
    @IBAction func button5(_ sender: Any) {
        input(input:"5")
    }
    @IBAction func button6(_ sender: Any) {
        input(input:"6")
    }
    @IBAction func button7(_ sender: Any) {
        input(input:"7")
    }
    @IBAction func button8(_ sender: Any) {
        input(input:"8")
    }
    @IBAction func button9(_ sender: Any) {
        input(input:"9")
    }
    @IBAction func button0(_ sender: Any) {
        input(input:"0")
    }
    @IBAction func buttonDot(_ sender: Any) {
        input(input:".")
    }
    
    @IBOutlet weak var plusCircle: UIImageView!
    @IBOutlet weak var plusSign: UIImageView!
    @IBOutlet weak var minusCircle: UIImageView!
    @IBOutlet weak var minusSign: UIImageView!
    @IBOutlet weak var multiplyCircle: UIImageView!
    @IBOutlet weak var multiplySign: UIImageView!
    @IBOutlet weak var divideCircle: UIImageView!
    @IBOutlet weak var divideSign: UIImageView!
    
    @IBAction func buttonPlus(_ sender: Any) {
        plusCircle.tintColor = UIColor.white
        plusSign.tintColor = UIColor.systemOrange
        calculate(operatorSign:"+")
    }
    
    @IBAction func buttonMinus(_ sender: Any) {
        minusCircle.tintColor = UIColor.white
        minusSign.tintColor = UIColor.systemOrange
        calculate(operatorSign:"-")
    }
    
    @IBAction func buttonMultiply(_ sender: Any) {
        multiplyCircle.tintColor = UIColor.white
        multiplySign.tintColor = UIColor.systemOrange
        calculate(operatorSign:"*")
    }
    
    @IBAction func buttonDivide(_ sender: Any) {
        divideCircle.tintColor = UIColor.white
        divideSign.tintColor = UIColor.systemOrange
        calculate(operatorSign:"/")
    }
    
    @IBAction func buttonPercent(_ sender: Any) {
        firstNum = result.text!
        calculate(operatorSign:"/")
        secondNum = "100"
        calculate(operatorSign:"=")
    }
    
    @IBAction func buttonClear(_ sender: Any) {
//        process.text = ""
        result.text = "0"
        firstNum = ""
        secondNum = ""
        firstNumChar = 0
        secondNumChar = 0
        math = ""
        startOver = true
    }
    @IBAction func buttonPlusMinus(_ sender: Any) {
        print("PM: " + firstNum + "," + secondNum)
        if inResult {
            isFirstNum = true
        }
        if result.text!.prefix(1) == "-" {
            result.text!.remove(at: result.text!.startIndex)
            
            if isFirstNum {
                firstNum.remove(at: firstNum.startIndex)
            }
            else {
                secondNum.remove(at: secondNum.startIndex)
            }
        }
        else {
            result.text = String("-") + result.text!
            if isFirstNum {
                firstNum = String("-") + firstNum
            }
            else {
                secondNum = String("-") + secondNum
            }
        }
        inResult = true
    }
    
    
    
    @IBAction func buttonEqual(_ sender: Any) {
        
        
        calculate(operatorSign:"=")
        
        
        
        
    }
    
}

//        if !(math.suffix(1) == "+" || math.suffix(1) == "-" || math.suffix(1) == "x" || math.suffix(1) == "/" || math.suffix(1) == "=") {
//
//            math = math.replacingOccurrences(of: "x", with: "*")
//
//            let expn = NSExpression(format:math)
//
//
//            lastResult = expn.expressionValue(with: nil, context: nil) as? Double ?? 0
//            process.text = String(lastResult) + operatorSign
//            result.text = String(lastResult)
//            if result.text!.suffix(2) == ".0" {
//                result.text!.remove(at: result.text!.index(before: result.text!.endIndex))
//                result.text!.remove(at: result.text!.index(before: result.text!.endIndex))
//            }
//            if operatorSign != "="{
//                math = result.text! + operatorSign
//            }
//            else {
//                math = ""
//            }
//            tempNum = ""
//
//        }
//        else {
//            process.text = process.text! + operatorSign
//
//        }
//        startOver = true
