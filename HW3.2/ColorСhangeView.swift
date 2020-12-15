//
//  ContentView.swift
//  HW3.2
//
//  Created by Сергей on 14.12.2020.
//

import SwiftUI

struct ColorСhangeView: View {
 
    @State private var value = (red: Double.random(in: 0...255),
                         blue: Double.random(in: 0...255),
                         green: Double.random(in: 0...255))
    
    var body: some View {
        
        VStack {
            RoundedRectangle(cornerRadius: 25.0)
                
                .foregroundColor(
                    Color(.sRGB,
                          red: value.red / 255,
                          green: value.green / 255,
                          blue: value.blue / 255)
                )
                .overlay(RoundedRectangle(cornerRadius: 25.0)
                            .stroke(lineWidth: 5)
                            .foregroundColor(.white))
                
                .frame(height: 180)
            
            ColorSliderAndLabels(value: $value.red, accentColor: .red)
            ColorSliderAndLabels(value: $value.green, accentColor: .green)
            ColorSliderAndLabels(value: $value.blue, accentColor: .blue)
            
            Spacer()
        }
        .padding()
    }
}




struct ColorSliderAndLabels: View {
    @Binding var value: Double
    let accentColor: Color
   
    var body: some View {
        
            HStack {
                Text("\(lround(value))")
                    
                    .frame(width: 40)

                Slider(value: $value, in: 0...255, step: 1)
                    .animation(.default)
                    .accentColor(accentColor)

                ColorTextField(sliderValue: $value)
                
            }
    }
      
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ColorСhangeView()
    }
}
