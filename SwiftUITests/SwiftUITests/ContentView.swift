//
//  ContentView.swift
//  SwiftUITests
//
//  Created by Fábio Salata on 11/08/20.
//

import SwiftUI

struct LabelView: View {
    @Binding var number: Int
    
    var body: some View {
        print("LabelView")
        
        return Group {
            if number > 0 {
                Text("You've tapped \(number) times")
            }
        }
    }
}

struct ContentView: View {
    @State var counter = 0
    
    var body: some View {
        print("contentView")
        
        return VStack {
            Button("Tap me!") { self.counter += 1 }
            LabelView(number: $counter)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
