//
//  Home.swift
//  ParallaxCarousel
//
//  Created by Fábio Salata on 04/12/20.
//

import SwiftUI

struct Home: View {
    @State var selected: Int = 0
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    var body: some View {
        TabView(selection: $selected) {
            ForEach(1...7, id: \.self) { index in
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                    GeometryReader { reader in
                        Image("p\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(x: -reader.frame(in: .global).minX)
                            .frame(width: width, height: height / 2)
                    }
                    .frame(height: height / 2)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: -5, y: -5)
                    .padding(10)
                    .background(Color.white)
                })
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
