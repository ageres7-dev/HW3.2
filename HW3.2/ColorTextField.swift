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
            .multilineTextAlignment(.center)
            .alert(isPresented: $showAlert) {
                UINotificationFeedbackGenerator().notificationOccurred(.error)
                return Alert(title: Text("Wrong number!"), message: Text("Enter a value between 0 and 255."))
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 60.0)
    }
}


 extension ColorTextField {
    
     private var action: () {
        
        guard var enteredNumber = Double(enteredValue) else {
            sliderValue = 0
            self.enteredValue = "0"
            showAlert = true
            return
        }

        if !(0...255).contains(enteredNumber) {
            enteredNumber = enteredNumber > 255 ? 255 : 0
            showAlert = true
        }
        
        sliderValue = enteredNumber
        self.enteredValue = String(lround(enteredNumber))
        print("fuck")

     }
 }
 
/*
 extension ColorTextField {
    //Вот не нравится как получилось, но несмог придумать лучще...
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
 */




struct ColorTextField_Previews: PreviewProvider {
    static var previews: some View {
        ColorTextField(sliderValue: .constant(0.8))
    }
}
