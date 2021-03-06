//
//  ViewController.swift
//  simple-calc
//
//  Created by Nattanon Bunyatipanon on 10/16/18.
//  Copyright © 2018 Nattanon Bunyatipanon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var historyOfInputs : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var txtDisplay: UILabel! // UI Label Reference
    
    @IBAction func btnPushedTrack(_ sender: Any) {
        
        let input : String = (sender as AnyObject).titleLabel!.text!
        var historyEq : String = ""
        
        switch input {
        case "=":
            
            let userInputArr : [String] = processEquation(userString: txtDisplay.text!)
                historyEq = txtDisplay.text! + " = "
            
            switch userInputArr[userInputArr.count - 1] {
            case "avg":
                let result : Int = avg(nums: userInputArr)
                historyEq += String(result)
                txtDisplay.text = String(result)
                break
            case "count":
                let result : Int = count(nums: userInputArr)
                historyEq += String(result)
                txtDisplay.text = String(result)
                break
            case "fact":
                let result : Int = fact(nums: userInputArr)
                historyEq += String(result)
                txtDisplay.text = String(result)
            case "+":
                let result : Int = add(nums: userInputArr)
                historyEq += String(result)
                txtDisplay.text = String(result)
            case "-":
                let result : Int = sub(nums: userInputArr)
                historyEq += String(result)
                txtDisplay.text = String(result)
            case "*":
                let result : Int = mul(nums: userInputArr)
                historyEq += String(result)
                txtDisplay.text = String(result)
            case "/":
                let result : Int = div(nums: userInputArr)
                historyEq += String(result)
                txtDisplay.text = String(result)
            case "%":
                let result : Int = mod(nums: userInputArr)
                historyEq += String(result)
                txtDisplay.text = String(result)
                
            default:
                txtDisplay.text = ""
            }
            
        case "AC":
            txtDisplay.text = ""
            
        default:
            if Int(input) != nil {
                txtDisplay.text = txtDisplay.text! + input
            } else {
                txtDisplay.text = txtDisplay.text! + " " + input + " "
            }
        }
        
        if historyEq != "" {
            self.historyOfInputs.append(historyEq)
        }
        
    }
    
    // Function to pass on data from one storyboard to another
    // Passes array of input strings.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistorySegue" {
            let secondVC = segue.destination as! HistoryViewController
            secondVC.stringOfInputs = self.historyOfInputs

        }
    }
    
    // Processes user input
    func processEquation(userString: String) -> [String] {
        var processedStringArr : [String] = []
        
        var fullEquationArr : [String] = userString.components(separatedBy: " ")

        
        if fullEquationArr[0] == "" {
            fullEquationArr.removeFirst()
        }
        
        if fullEquationArr[fullEquationArr.count-1] == "" {
            fullEquationArr.removeLast()
        }

        var endOfArr : Int = fullEquationArr.count - 1
        var i : Int = 0
        
        while i < endOfArr {

            let charToProcess = fullEquationArr[i]
            if charToProcess == "-" {
                if i == 0 || (i > 0 && Int(fullEquationArr[i - 1]) == nil) {
                    fullEquationArr[i+1] = charToProcess + fullEquationArr[i + 1]
                    fullEquationArr.remove(at: i)
                    endOfArr -= 1
                    i -= 1
                }
            }
            i += 1
        }

        
        
        
        switch fullEquationArr[1] {
        case "avg", "count":
            for index in 0...fullEquationArr.count - 1 {

                if fullEquationArr[index] != "avg" && fullEquationArr[index] != "count" {
                    processedStringArr.append(fullEquationArr[index])
                }
            
            }
            fullEquationArr[1] == "avg" ? processedStringArr.append("avg") : processedStringArr.append("count")
            break
        default:
            for index in 0...fullEquationArr.count-1 {
                if Int(fullEquationArr[index]) != nil {
                    processedStringArr.append(fullEquationArr[index])
                }
            }
            processedStringArr.append(fullEquationArr[1])
            break
        }
        
        return processedStringArr
    }
    
    // Addition for Calculator
    func add( nums: [String]) -> Int {
        let number1 : Int = Int(nums[0])!
        let number2 : Int = Int(nums[1])!
        
        return number1 + number2
    }
    
    // Subtraction for Calculator
    func sub( nums: [String]) -> Int {
        let number1 : Int = Int(nums[0])!
        let number2 : Int = Int(nums[1])!
        
        return number1 - number2
    }
    
    // Modular for Calculator
    func mod( nums: [String]) -> Int {
        let number1 : Int = Int(nums[0])!
        let number2 : Int = Int(nums[1])!
        
        return (number1 % number2 + number2) % number2
    }
    
    // Multiply for Calculator
    func mul( nums: [String]) -> Int {
        let number1 : Int = Int(nums[0])!
        let number2 : Int = Int(nums[1])!
        
        return number1 * number2
    }
    
    // Division for Calculator
    func div( nums: [String]) -> Int {
        let number1 : Int = Int(nums[0])!
        let number2 : Int = Int(nums[1])!
        
        return number1 / number2
    }
    
    // Average function for Calculator
    func avg( nums: [String]) -> Int {
        var average : Int = 0
        
        for i in 0...nums.count-2 {
            let toAdd : Int = Int(nums[i])!
            average += toAdd
        }
        
        return average / (nums.count - 1)
    }
    
    // Factorial function for Calculator
    func fact( nums: [String]) -> Int {
        let number : Int = abs(Int(nums[0])!)
        var computedFact : Int = 1
        if number == 1 || number == 0 {
            return 1
        } else {
            for i in stride(from: number, to: 1, by: -1) {
                computedFact *= i
            }
        }
        return Int(nums[0])! > 0 ? computedFact : -computedFact
    }
    
    // Count function for Calculator
    func count( nums: [String]) -> Int {
        return nums.count - 1
    }
}

