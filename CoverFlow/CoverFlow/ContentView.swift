//
//  ContentView.swift
//  CoverFlow
//
//  Created by Fábio Salata on 12/09/20.
//

import SwiftUI

struct ContentView: View {
    @GestureState private var dragAmount = CGSize.zero
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 300, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .rotation3DEffect(
                        .degrees(-Double(self.dragAmount.width) / 20),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .rotation3DEffect(
                        .degrees(Double(self.dragAmount.height) / 20),
                        axis: (x: 1.0, y: 0.0, z: 0.0)
                    )
                    .offset(self.dragAmount)
                    .gesture(
                        DragGesture().updating($dragAmount) { value, state, transactions in
                            state = value.translation
                        }
                    )
                
            }
        }.frame(width: 300, height: 200)
    }
}

//struct ContentView: View {
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 0) {
//                ForEach(1..<10) { num in
//                    VStack {
//                        GeometryReader { geometry in
//                            Text("Number \(num)")
//                                .font(.largeTitle)
//                                .padding()
//                                .background(Color.red)
//                                .rotation3DEffect(
//                                    .degrees(-Double(geometry.frame(in: .global).minX) / 8),
//                                    axis: (x: 0.0, y: 1.0, z: 0.0)
//                                )
//                        }
//                    }
//                    .frame(width: 180)
//                }
//            }
//            .padding()
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
