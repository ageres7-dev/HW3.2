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
            ColorView(red: value.red, green: value.green, blue: value.blue)
        
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

struct ColorView: View {
    let red: Double
    let green: Double
    let blue: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(
                Color(.sRGB,
                      red: red / 255,
                      green: green / 255,
                      blue: blue / 255)
            )
            .shadow(radius: 15 )
            .overlay(RoundedRectangle(cornerRadius: 25.0)
                        .stroke(lineWidth: 5)
                        .foregroundColor(.white))
            .frame(height: 180)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ColorСhangeView()
            .preferredColorScheme(.light)
    }
}
