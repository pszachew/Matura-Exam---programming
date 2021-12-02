//
//  ContentView.swift
//  cw3
//
//  Created by apios on 01/12/2021.
//

import SwiftUI

let primaryColor = Color.init(red: 0, green: 116/255, blue: 178/255, opacity: 1.0)

let rows = [
    ["7", "8", "9", "/"],
    ["4", "5", "6", "*"],
    ["1", "2", "3", "-"],
    [".", "0", "=", "+"]
]

class Model: ObservableObject {
    @Published var expr: [String] = []
    
    init() {
        
    }
    
    func onClick(_ column: String) {
        if column == "=" {
            expr = [eval()]
            return
        } else if isOperator(column) {
            if !expr.isEmpty && isOperator(expr[expr.count-1]) {
                expr[expr.count-1] = column
            } else if !expr.isEmpty || expr[expr.count-1] != "" {
                expr.append(column)
            }
        } else { //number
            if !expr.isEmpty && !isOperator(expr[expr.count-1]) {
                expr[expr.count-1] = expr[expr.count-1] + column
            } else {
                expr.append(column)
            }
        }
    }
    
    func eval() -> String {
        if expr.count < 3 {
            return ""
        }
        
        var a = Double(expr[0])
        var b = Double("0.0")
        let exprSize = expr.count
        
        for i in (1...exprSize-2) {
            b = Double(expr[i+1])
            
            switch expr[i] {
            case "+":
                a! += b!
            case "-":
                a! -= b!
            case "*":
                a! *= b!
            case "/":
                a! /= b!
            default:
                print("illegal state")
            }
        }
        
        return String(format: "%.1f", a!)
    }
    
    func isOperator(_ s: String) -> Bool {
        if s == "+" || s == "-" || s == "*" || s == "/" {
            return true
        }
        return false
    }
}



struct ContentView: View {
    @ObservedObject var model: Model = Model()
    
    var body: some View {
        VStack {
            Text(model.expr.description)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 400, idealHeight: 500, maxHeight: .infinity, alignment: .center)
            ForEach(rows, id: \.self) { row in
                HStack(alignment: .top, spacing: 0) {
                    ForEach(row, id: \.self) { column in
                        Button(action: {
                            model.onClick(column)
                        }, label: {
                            Text(column)
                                .frame(idealWidth: 200, maxWidth: .infinity, idealHeight: 200, maxHeight: .infinity, alignment: .center)
                        })
                    }
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
