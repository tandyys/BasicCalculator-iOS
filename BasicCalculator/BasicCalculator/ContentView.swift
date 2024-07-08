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
                    .font(Font.custom("HelveticaNeue-Thin", size: 24))
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
                                    //Action to be added later.
                                }, label: {
                                    Text(column)
                                    .font(.system(size: getFontSize(btnTxt: column)))
                                    .frame(idealWidth: 100, maxWidth: .infinity, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                                })
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
        .edgesIgnoringSafeArea(.all)
    }
}

func flattenTheExpression(exps: [String]) -> String {
    var calExp = ""
    for exp in exps {
        calExp.append(exp)
    }
    return calExp
}

// Return differnt font sizes for operators and numbers.
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

#Preview {
    ContentView()
}
