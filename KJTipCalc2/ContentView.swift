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

/// Right-justified bold text displayed in the middle column
private struct MiddleText : View {
    let content: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(content)
                .bold()
        }
        .frame(width: middleColumnWidth)
    }
}

private struct TipCalcView : View {
    @State private var subtotalText = "12.34"
    @State private var tipPercentageText = "18"
    @State private var numberInPartyText = "1"
    
    private var tip = "0.00"
    private var total = "0.00"
    private var perPerson = "0.00"

    var body: some View {
        VStack {
            HStack {
                LeftText(content: "Subtotal")
                
                TextField($subtotalText,
                          placeholder: Text("Price"),
                          onEditingChanged: { _ in })
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .frame(width: middleColumnWidth)

                Button(action: {}) {
                    Text("Clear")
                }
                
                Spacer()
            }
            
            HStack {
                LeftText(content: "Tip %")
                
                TextField($tipPercentageText,
                          placeholder: Text("Tip %"),
                          onEditingChanged: { _ in })
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .frame(width: middleColumnWidth)
                
                Stepper(onIncrement: {},
                        onDecrement: {},
                        label: { EmptyView() })
                
                Spacer()
            }
            
            HStack {
                LeftText(content: "Party of")
                
                TextField($numberInPartyText,
                          placeholder: Text("Count"),
                          onEditingChanged: { _ in })
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .frame(width: middleColumnWidth)
                
                Stepper(onIncrement: {},
                        onDecrement: {},
                        label: { EmptyView() })
                
                Spacer()
            }
            
            Divider()
            
            HStack {
                LeftText(content: "Tip")
                MiddleText(content: tip)
                Spacer()
            }
            .padding(.top)
            
            HStack {
                LeftText(content: "Total")
                MiddleText(content: total)
                Spacer()
            }
            .padding(.top)
            
            HStack {
                LeftText(content: "Per person")
                MiddleText(content: perPerson)
                Spacer()
            }
            .padding(.top)
        }
        .padding(.leading)
        .frame(width: frameWidth)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
