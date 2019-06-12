//
//  ContentView.swift
//  KJTipCalc2
//
//  Created by Kristopher Johnson on 6/8/19.
//  Copyright © 2019 Kristopher Johnson. All rights reserved.
//

import SwiftUI

/// Main content view layout
struct ContentView : View {
    var body: some View {
        // Center the TipCalcView horizontally and position it
        // near the top of the display.
        HStack {
            Spacer()
            VStack {
                TipCalcView()
                Spacer()
            }
            Spacer()
        }
        .padding(.top)
    }
}

// We use fixed-width values so that we can line things up in columns,
// and so the layout is not too wide on large displays.
//
// TODO: Figure out if "alignment guides" would work instead.
private let frameWidth: Length = 320
private let leftColumnWidth: Length = 110
private let middleColumnWidth: Length = 90

/// Left-justified text displayed in the left column
private struct LeftText : View {
    let content: String
    
    var body: some View {
        HStack {
            Text(content)
            Spacer()
        }
        .frame(width: leftColumnWidth)
    }
}

/// Right-justified read-only text displayed in the middle column
private struct MiddleTextField : View {
    let content: String
    
    var body: some View {
        HStack {
            Spacer()
            TextField(.constant(content))
                .font(.headline)
                .multilineTextAlignment(.trailing)
        }
        .frame(width: middleColumnWidth)
    }
}

private struct TipCalcView : View {
    @State private var subtotalText = "12.34"
    
    @State private var subtotal = 20.00
    @State private var tipPercentage = 18
    @State private var numberInParty = 1
    
    var isValidSubtotal: Bool {
        subtotal > 0.0
    }
    
    var tip: Double {
        subtotal * Double(tipPercentage) / 100.0
    }
    
    var total: Double {
        subtotal + tip
    }
    
    var perPerson: Double {
        total / Double(numberInParty)
    }
    
    var body: some View {
        VStack {
            HStack {
                LeftText(content: "Subtotal")
                
                TextField($subtotalText,
                          placeholder: Text("Price"),
                          onEditingChanged: { _ in })
                    .font(.headline)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .frame(width: middleColumnWidth)
                    .layoutPriority(1)

                Button(action: onClearSubtotal) {
                    Text("Clear")
                }
                
                Spacer()
            }
            
            HStack {
                LeftText(content: "Tip %")
                MiddleTextField(content: "\(tipPercentage)")
                    .layoutPriority(1)
                Stepper(onIncrement: onIncrementTipPercentage,
                        onDecrement: onDecrementTipPercentage,
                        label: { EmptyView() })
                
                Spacer()
            }
            
            HStack {
                LeftText(content: "Party of")
                MiddleTextField(content: "\(numberInParty)")
                    .layoutPriority(1)
                Stepper(onIncrement: onIncrementNumberInParty,
                        onDecrement: onDecrementNumberInParty,
                        label: { EmptyView() })
                
                Spacer()
            }
            
            Divider()
            
            HStack {
                LeftText(content: "Tip")
                MiddleTextField(content: isValidSubtotal
                    ? String(format: "%.2f", tip)
                    : " ")
                    .layoutPriority(1)
                Spacer()
            }
            .padding(.top)
            
            HStack {
                LeftText(content: "Total")
                MiddleTextField(content: isValidSubtotal
                    ? String(format: "%.2f", total)
                    : " ")
                    .layoutPriority(1)
                Spacer()
            }
            .padding(.top)
            
            HStack {
                LeftText(content: "Per person")
                MiddleTextField(content: isValidSubtotal
                    ? String(format: "%.2f", perPerson)
                    : " ")
                    .layoutPriority(1)
                Spacer()
            }
            .padding(.top)
        }
        .padding(.leading)
        .frame(width: frameWidth)
    }
    
    private func onClearSubtotal() {
        subtotalText = ""
    }
    
    private func onIncrementTipPercentage() {
        if tipPercentage < 100 {
            tipPercentage += 1
        }
    }
    
    private func onDecrementTipPercentage() {
        if tipPercentage > 1 {
            tipPercentage -= 1
        }
    }
    
    private func onIncrementNumberInParty() {
        if numberInParty < 20 {
            numberInParty += 1
        }
    }
    
    private func onDecrementNumberInParty() {
        if numberInParty > 1 {
            numberInParty -= 1
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
