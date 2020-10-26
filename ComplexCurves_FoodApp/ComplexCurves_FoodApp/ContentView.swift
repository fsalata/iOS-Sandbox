//
//  ContentView.swift
//  ComplexCurves_FoodApp
//
//  Created by Fábio Salata on 26/10/20.
//

import SwiftUI

var tabs = ["Shakes", "Coffee", "Drinks", "Cocktail"]

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var midY: CGFloat = 0
    @State var selected = tabs.first
    
    var body: some View {
        HStack {
            VStack {
                Button(action: {}, label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.title2)
                        .foregroundColor(.white)
                })
                
                Spacer(minLength: 0)
                
                ForEach(tabs, id: \.self) { name in
                    ZStack {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 13, height: 13)
                            .offset(x: selected   == name ? 28 : -80)
                        
                        Color.purple
                            .frame(width: 150, height: 110)
                            .rotationEffect(.init(degrees: -90))
                            .offset(x: -50)
                        
                        GeometryReader { geometry in
                            Button(action: {
                                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.65, blendDuration: 0.65)) {
                                    self.midY = geometry.frame(in: .global).midY
                                    self.selected = name
                                }
                            }, label: {
                                Text(name)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                            })
                            .frame(width: 150, height: 110)
                            .rotationEffect(.init(degrees: -90))
                            .onAppear {
                                if name == tabs.first {
                                    self.midY = geometry.frame(in: .global).midY
                                }
                            }
                            .offset(x: -8)
                        }
                        .frame(width: 150, height: 110)
                    }
                }
                
                Spacer(minLength: 0)
            }
            .frame(width: 70)
            .background(Color.purple
                            .clipShape(Curve(midY: midY))
                            .ignoresSafeArea())
            
            Spacer()
        }
    }
}

struct Curve: Shape {
    var midY: CGFloat
    
    var animatableData: CGFloat {
        get { return midY }
        set { midY = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let width = rect.width
            
            path.move(to: CGPoint(x: width, y: midY - 40))
            
            let to = CGPoint(x: width - 25, y: midY)
            let control1 = CGPoint(x: width, y: midY - 20)
            let control2 = CGPoint(x: width - 25, y: midY - 20)
            
            path.addCurve(to: to, control1: control1, control2: control2)
            
            let to1 = CGPoint(x: width, y: midY + 40)
            let control3 = CGPoint(x: width - 25, y: midY + 20)
            let control4 = CGPoint(x: width, y: midY + 20)
            
            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
