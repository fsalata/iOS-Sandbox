//
//  ContentView.swift
//  Knob
//
//  Created by Chris Eidhof on 05.11.19.
//  Copyright © 2019 Chris Eidhof. All rights reserved.
//

import SwiftUI

struct KnobShape: Shape {
    var pointerSize: CGFloat = 0.1 // these are relative values
    var pointerWidth: CGFloat = 0.1
    func path(in rect: CGRect) -> Path {
        let pointerHeight = rect.height * pointerSize
        let pointerWidth = rect.width * self.pointerWidth
        let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
        return Path { p in
            p.addEllipse(in: circleRect)
            p.addRect(CGRect(x: rect.midX - pointerWidth/2, y: 0, width: pointerWidth, height: pointerHeight + 2))
        }
    }
}

struct Knob: View {
    @Binding var value: Double // should be between 0 and 1
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.knobColor) var knobColor
    
    var useCustomColor: Bool = false
    

    var body: some View {
         KnobShape()
            .fill(useCustomColor == false ? (colorScheme == .dark ? Color.white : Color.black) : knobColor!)
            .rotationEffect(Angle(degrees: value * 330))
            .onTapGesture {
                withAnimation(.default) {
                    self.value = self.value < 0.5 ? 1 : 0
                }
            }
    }
}

struct ContentView: View {
    @State var value: Double = 0.5
    @State var knobSize: CGFloat = 0.1
    @State var hue: Double = 0
    @State var useCustomColor: Bool = false

    var body: some View {
        VStack {
            Knob(value: $value, useCustomColor: useCustomColor)
                .frame(width: 100, height: 100)
                .knobColor(Color(hue: hue, saturation: 1, brightness: 1))
            HStack {
                Text("Value")
                Slider(value: $value, in: 0...1)
            }
            HStack {
                Text("Knob Size")
                Slider(value: $knobSize, in: 0...0.4)
            }
            VStack {
                Toggle("Custom Color", isOn: $useCustomColor)
                HStack {
                    Text("Knob color")
                    Slider(value: $hue, in: 0...1, step: 0.1)
                }
                .foregroundColor(useCustomColor ? .black : .gray)
                .disabled(!useCustomColor)
            }
            
            Button(action: {
                withAnimation(.default) {
                    self.value = self.value == 0 ? 1 : 0
                }
            }, label: { Text("Toggle")})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

// Environment
fileprivate struct KnobColorKey: EnvironmentKey {
    static let defaultValue: Color? = nil
}

extension View {
    func knobColor(_ color: Color) -> some View {
        environment(\.knobColor, color)
    }
}

extension EnvironmentValues {
    var knobColor: Color? {
        get { self[KnobColorKey.self] }
        set { self[KnobColorKey.self] = newValue}
    }
}
