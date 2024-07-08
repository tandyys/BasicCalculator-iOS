//
//  ContentView.swift
//  BasicCalculator
//
//  Created by tandyys on 08/07/24.
//

import SwiftUI

let primaryColor = Color.init(red: 0.502, green: 0.0, blue: 0.0, opacity: 1.0)

struct ContentView: View {
    
    // Array with button titles for each
    let rows = [
        ["7", "8", "9", "÷"],
        ["4", "5", "6", "×"],
        ["1", "2", "3", "−"],
        [".", "0", "=", "+"]
    ]
    
    // ... @Stack variales are defined here
    @State var finalValue:String = "Calculator Apps"
    // This holds the expression which has been entered by the user.
    @State var calExpression: [String] = []
    // Holds number that user insert
    @State var noBeingEntered: String = ""
    
    var body: some View {
        VStack {
            VStack {
                // This text display the result of the expression
                Text(self.finalValue)
                    .font(Font.custom("HelveticaNeue-Thin", size: 72))
                    .frame(idealWidth: 100, maxWidth: .infinity, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                    .foregroundColor(primaryColor)
                // This text displayes the expression that the user has entered till now
                Text(flattenTheExpression(exps: calExpression))
                    .font(Font.custom("HelveticaNeue-Thin", size: 52))
                    .frame(alignment: Alignment.bottomTrailing)
                    .foregroundColor(primaryColor)
                            
                // This will give a bottom padding to our Text above.
                Spacer()

            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.white)
            VStack {
                Spacer(minLength: 48)
                VStack(spacing: 0) {
                    ForEach(rows, id: \.self) { row in
                        HStack(alignment: .top, spacing: 0) {
                            Spacer()
                            ForEach(row, id: \.self) { column in
                                Button(action: {
                                    if column == "=" {
                                        self.calExpression = []
                                        self.noBeingEntered = ""
                                        return
                                    } else if checkIfOperator(str: column)  {
                                        self.calExpression.append(column)
                                        self.noBeingEntered = ""
                                    } else {
                                        self.noBeingEntered.append(column)
                                        if self.calExpression.count == 0 {
                                            self.calExpression.append(self.noBeingEntered)
                                        } else {
                                            if !checkIfOperator(str: self.calExpression[self.calExpression.count-1]) {
                                                self.calExpression.remove(at: self.calExpression.count-1)
                                            }

                                            self.calExpression.append(self.noBeingEntered)
                                        }
                                    }

                                    self.finalValue = processExpression(exp: self.calExpression)
                                    // This code ensures that future operations are done on evaluated result rather than evaluating the expression from scratch.
                                    if self.calExpression.count > 3 {
                                        self.calExpression = [self.finalValue, self.calExpression[self.calExpression.count - 1]]
                                    }

                                }, label: {
                                  Text(column)
                                  .font(.system(size: getFontSize(btnTxt: column)))
                                  .frame(idealWidth: 100, maxWidth: .infinity, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                                }
                                )
                                .foregroundColor(Color.white)
                                .background(getBackground(str: column))
                                .mask(CustomShape(radius: 40, value: column))
                            }
                        }
                    }
                }
            }
            .background(Color.black)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 414, maxHeight: .infinity, alignment: .topLeading)
        }
        .background(Color.black)
//        .edgesIgnoringSafeArea(.all)
    }
}

func flattenTheExpression(exps: [String]) -> String {
    var calExp = ""
    for exp in exps {
        calExp.append(exp)
    }
    return calExp
}

// If its operator, then the BG Color is red
func getBackground(str:String) -> Color {
    
    if checkIfOperator(str: str) {
        return primaryColor
    }
    return Color.black
}

// Return differnt font sizes for operators and numbers.
func getFontSize(btnTxt: String) -> CGFloat {
    
    if checkIfOperator(str: btnTxt) {
        return 42
    }
    return 24
    
}

// This function returns if the passed argument is a operator or not.
func checkIfOperator(str:String) -> Bool {
    
    if str == "÷" || str == "×" || str == "−" || str == "+" || str == "=" {
        return true
    }
    
    return false
    
}

func processExpression(exp:[String]) -> String {
    
    if exp.count < 3 {
        // Less than 3 means that expression doesnt contain the 2nd no.
        return "0.0"
    }
    
    var a = Double(exp[0])  // Get the first no
    var c = Double("0.0")   // Init the second no
    let expSize = exp.count
    
    for i in (1...expSize-2) {
        
        c = Double(exp[i+1])
        
        switch exp[i] {
        case "+":
            a! += c!
        case "−":
            a! -= c!
        case "×":
            a! *= c!
        case "÷":
            a! /= c!
        default:
            print("skipping the rest")
        }
    }
    
    return String(format: "%.1f", a!)
}

#Preview {
    ContentView()
}
