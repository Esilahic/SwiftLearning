//
//  ViewController.swift
//  Calc
//
//  Created by Emil Silahic on 2/26/21.
//

import UIKit

extension Double {
    func round(to places: Int) -> Double
    {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter =
        {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = " "
            return formatter
        }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}


class ViewController: UIViewController {

    @IBOutlet weak var CalcWorkings: UILabel!
    @IBOutlet weak var CalcResults: UILabel!
    
    var Workings:String = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AllClear()
    }

    func AllClear() {
        Workings = " "
        CalcWorkings.text = " "
        CalcResults.text = " "
    }

    @IBAction func AllClear(_ sender: Any) {
        AllClear()
    }
    @IBAction func Backspace(_ sender: Any) {
        if (!Workings.isEmpty) {
            Workings.removeLast()
            CalcWorkings.text = Workings
        }
    }
    
    func addToWorkings(value: String) {
        Workings = Workings + value
        CalcWorkings.text = Workings
    }
    
    @IBAction func Percentage(_ sender: Any) {
        addToWorkings(value: "%")
    }
    @IBAction func Divide(_ sender: Any) {
        addToWorkings(value: "/")
    }
    @IBAction func Multiply(_ sender: Any) {
        addToWorkings(value: "*")
    }
    @IBAction func Minus(_ sender: Any) {
        addToWorkings(value: "-")
    }
    @IBAction func Add(_ sender: Any) {
        addToWorkings(value: "+")
    }
    @IBAction func Equal(_ sender: Any) {
        if (validInput()) {
            
        let checkWorkingsForPercent = Workings.replacingOccurrences(of: "%", with: "*0.01")
        let expression = NSExpression(format: checkWorkingsForPercent)
        let result = expression.expressionValue(with: nil, context: nil) as! Double
        let resultString = formatResult(result: result)
        CalcResults.text = resultString
      
        }
        else {
            let alert = UIAlertController(title: "Invlaid Input", message: "Input is invalid", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func validInput() -> Bool {
        
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in Workings {
            if(specialCharacter(char: char)){
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        var previous: Int = -1
        
        for index in funcCharIndexes {
            if (index == 0) {
                return false
            }
            if (index == Workings.count - 1){
                return false
            }
            if (previous != -1){
                if(index - previous == 1) {
                    return false
                }
            }
        previous = index
        }
        
        return true
    }
    
    func specialCharacter (char:Character) -> Bool {
        if(char == "*"){
            return true
        }
        
        if(char == "/"){
            return true
        }
        
        if(char == "+"){
            return true
        }
        return false
    }
    
    func formatResult(result: Double) -> String {
        var roundedResult: Double
        if(result.truncatingRemainder(dividingBy: 1) == 0) {
            roundedResult = result.round(to: 0) //return String(format: "%.0f", result)
        }
        else {
            roundedResult = result.round(to: 2) //return String(format: "%.2f", result)
        }
        
        return roundedResult.formattedWithSeparator
    }
    
    @IBAction func Decimal(_ sender: Any) {
        addToWorkings(value: ".")
    }
    @IBAction func Zero(_ sender: Any) {
        addToWorkings(value: "0")
    }
    @IBAction func One(_ sender: Any) {
        addToWorkings(value: "1")
    }
    @IBAction func Two(_ sender: Any) {
        addToWorkings(value: "2")
    }
    @IBAction func Three(_ sender: Any) {
        addToWorkings(value: "3")
    }
    @IBAction func Four(_ sender: Any) {
        addToWorkings(value: "4")
    }
    @IBAction func Five(_ sender: Any) {
        addToWorkings(value: "5")
    }
    @IBAction func Six(_ sender: Any) {
        addToWorkings(value: "6")
    }
    @IBAction func Seven(_ sender: Any) {
        addToWorkings(value: "7")
    }
    @IBAction func Eight(_ sender: Any) {
        addToWorkings(value: "8")
    }
    @IBAction func Nine(_ sender: Any) {
        addToWorkings(value: "9")
    }
}

