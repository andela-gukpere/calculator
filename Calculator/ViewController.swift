//
//  ViewController.swift
//  Calculator
//
//  Created by Godson Ukpere on 2/26/15.
//  Copyright (c) 2015 Godson Ukpere. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var operandLabel: UILabel!
    
    var userIsTyping:Bool = false
    
    @IBAction func appendDigit(sender: UIButton, forEvent event: UIEvent) {
        let digit:String! = sender.currentTitle!
        var displayText:String? = display.text
        if userIsTyping {
            display.text = displayText! + digit!
        }
        else {
            display.text = digit
            userIsTyping = true
        }
        println ("digit \(digit)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup afte r loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     class Operations {
        var num:Int = 0
        class func multiply(op1:Double, op2:Double) -> Double {
            return op1 * op2
        }
        
        class func sum(op1:Double, op2:Double) -> Double {
            return op1 + op2
        }
        
        class func substract(op1:Double, op2:Double) -> Double {
            return op1 - op2
        }
        
        class func divide(op1:Double, op2:Double) -> Double {
            return op1 / op2
        }
    }
    
    var operandStack:Array<Double> = Array<Double>()
    
    @IBAction func enter() {
        userIsTyping = false
        operandStack.append(displayValue)        
        operandLabel.text? += String.convertFromStringInterpolationSegment(displayValue)

        println("operand appended \(operandStack)")
    }
    
    @IBAction func operate(sender: UIButton, forEvent event: UIEvent) {
        let operation = sender.currentTitle!
        
        var result:Double = 0
        operandLabel.text? += operation + " "
        switch operation {
            case "+":
                performOperation({(op1, op2)-> Double in return op1 + op2})
            break
            case "-":
                performOperation {$1 - $0}
            break
            case "×":
                performOperation({(op1, op2) in op1 + op2})
            break
            case "÷":
                performOperation({$1 / $0})
            break
            case "√": performOperation {sqrt($0)}
            case "sin": performOperation {sin($0)}
            case "cos": performOperation {cos($0)}
            case "tan": performOperation {tan($0)}
            case "C":
                operandStack.removeAll(keepCapacity: false)
                displayValue = 0
                break
            default:
                return
        }
    }
    
    func performOperation (operation: (Double, Double) -> Double){
        if(operandStack.count >= 2) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation (operation: (Double) -> Double){
        if(operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsTyping = false
        }
    }

}

