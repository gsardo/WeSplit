//
//  ContentView.swift
//  WeSplit
//
//  Created by Giuseppe Sardo on 20/4/2022.
//

// main UI for the program

import SwiftUI // use all functionality provided by SwiftUI framework

struct ContentView: View {
    // views are a function of their state. The way our UI looks, are determined by the state of the program
    
    //@State allows the view to be updated as the program changes
    @State private var billAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    //@FocusState handles input focus for the UI
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2) //We + 2 as the 0th position of the picker is 0
        let tipSelection = Double(tipPercentage)
        
        let tipValue = billAmount / 100 * tipSelection
        let grandTotal = billAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
        
    var body: some View { // required property
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $billAmount, format: .currency(code: Locale.current.currencyCode ?? "AUD")) //the $ pre-fix means that it is two-way binding, which reads the value of the property and then writes it back to the property when it changes
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Total bill amount")
                }
                .textCase(nil)
                
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<13) {
                            Text("\($0) people")
                        }
                    }
                }
                .textCase(nil)
                
                Section{
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { // SwiftUI needs to identify every unique view on the screen. The strings of the array are unique
                            Text($0, format: .percent)
                        } 
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                .textCase(nil)
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "AUD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                } header: {
                    Text("Total WeSplit")
                }
                .textCase(nil)
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider { // does not appear in the program, just used for preview & debugging
    static var previews: some View {
        ContentView()
    }
}
