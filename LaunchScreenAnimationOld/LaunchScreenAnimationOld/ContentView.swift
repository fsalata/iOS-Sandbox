//
//  ContentView.swift
//  LaunchScreenAnimationOld
//
//  Created by Fábio Salata on 04/10/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Home()
            AnimatedSplash()
        }
    }
}

struct AnimatedSplash: View {
    @State var animate = false
    @State var enlarge = false
    @State var endSplash = false
    
    var body: some View {
        ZStack {
            Color("bg")
            
            Image("twitter-large")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: animate ? .fill : .fit)
                .frame(width: 85, height: 85)
                .scaleEffect(animate ? getLogoSize() : 1)
                .frame(width: UIScreen.main.bounds.width)
        }
        .opacity(endSplash ? 0 : 1)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.animateSplash()
        }
    }
    
    func getLogoSize() -> CGFloat {
        return enlarge ? 10 : 0.6
    }
    
    func animateSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(.easeOut(duration: 0.25)) {
                self.animate.toggle()
            }
            
            withAnimation(Animation.easeOut(duration: 0.5)) {
                self.enlarge.toggle()
            }
            
            withAnimation(.linear(duration: 0.45)) {
                self.endSplash.toggle()
            }
        }
    }
}

struct Home: View {
    var body: some View {
        VStack {
            HStack {
                Text("Twitter")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("bg"))
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            
            Image("scarlett")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
