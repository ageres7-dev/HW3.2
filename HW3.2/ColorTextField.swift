//
//  ColorTextField.swift
//  HW3.2
//
//  Created by Сергей on 15.12.2020.
//

import SwiftUI

struct ColorTextField: View {
    
    @State private var showAlert = false
    @State private var enteredValue = ""
    @Binding var sliderValue: Double
    
    var body: some View {
        
        let bindingEnteredValue = Binding(
           get: { String(lround(self.sliderValue)) },
           set: { self.enteredValue = $0 }
       )
        
        TextField("Value", text: bindingEnteredValue, onCommit: { action })
            
        
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Wrong Format!"), message: Text("Enter number of range 0 to 255"))
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 60.0)
    }
}



extension ColorTextField {
    private var action: () {
        if var enteredNumber = Double(enteredValue) {
            
            switch enteredNumber {
            case ..<0 :
                enteredNumber = 0
                showAlert = true
            case 256... :
                enteredNumber = 255
                showAlert = true
            default: break
            }
            sliderValue = enteredNumber
            self.enteredValue = String(lround(enteredNumber))
            
        } else {
            sliderValue = 0
            self.enteredValue = "0"
            showAlert = true
        }
    }
}