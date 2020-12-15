//
//  ContentView.swift
//  HW3.2
//
//  Created by Сергей on 14.12.2020.
//

import SwiftUI

struct ColorСhangeView: View {
 
    @State private var showAlert = false
    
    @State private var value = (red: Double.random(in: 0...255),
                         blue: Double.random(in: 0...255),
                         green: Double.random(in: 0...255))
    {
        didSet {
            enteredValue.red = String(value.red)
            enteredValue.green = String(value.green)
            enteredValue.blue = String(value.blue)
        }
    }
    
    @State private var enteredValue = (red: "" ,green: "", blue: "")
  
  
    
    var body: some View {
        
        let bindingSlider = Binding(
            get: {
                self.value.red
            },
            set: {
                self.value.red = $0
                self.enteredValue.red = String(lround($0))
            }
        )
        
        let bindingEnteredValue = Binding(
            get: {
//                self.enteredValue.red
                String(lround(self.value.red))
                
            },
            set: {
                self.enteredValue.red = $0
//                self.value.red = Double($0) ?? 0
            }
        )
        
        VStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(
                    Color(.sRGB,
                          red: value.red / 255,
                          green: value.green / 255,
                          blue: value.blue / 255)
                )
                .frame(height: 200)
            
            HStack {
                Text("\(lround(value.red))")
                    .frame(width: 60)
//                Slider(value: $value.red, in: 0...255, step: 1)
                
                Slider(value: bindingSlider, in: 0...255, step: 1)
                    .animation(.default)
                    .accentColor(.red)
//                TextField("", text: $enteredValue.red)

                TextField("Value", text: bindingEnteredValue, onCommit: {
                    
                    if var enteredNumber = Double(enteredValue.red) {
                        
                        switch enteredNumber {
                        case ..<0 :
                            enteredNumber = 0
                            showAlert = true
                        case 256... :
                            enteredNumber = 255
                            showAlert = true
                        default: break
                        }
                        value.red = enteredNumber
                        self.enteredValue.red = String(lround(enteredNumber))
                        
                    } else {
                        value.red = 0
                        self.enteredValue.red = "0"
                        showAlert = true
                    }
                })
                
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Wrong Format!"), message: Text("Enter number of range 0 to 255"))
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 60)
                
                
            }
            Spacer()
        }
        .padding()
    }
    
}



extension ColorСhangeView {
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ColorСhangeView()
    }
}
