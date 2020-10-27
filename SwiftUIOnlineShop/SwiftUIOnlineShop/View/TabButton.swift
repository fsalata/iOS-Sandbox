//
//  TabButton.swift
//  SwiftUIOnlineShop
//
//  Created by Fábio Salata on 27/10/20.
//

import SwiftUI

struct TabButton: View {
    var title: String
    @Binding var selectedTab: String
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selectedTab = title
            }
        }, label: {
            VStack(alignment: .leading, spacing: 6, content: {
                Text(title)
                    .fontWeight(.heavy)
                    .foregroundColor(selectedTab == title ? .black : .gray)
                
                if selectedTab == title {
                    Capsule()
                        .fill(Color.black)
                        .frame(width: 40, height: 4)
                        .matchedGeometryEffect(id: "Tab", in: animation)
                }
            })
            .frame(width: 100)
        })
    }
}

struct TabButton_Previews: PreviewProvider {
    @Namespace static var animation
    static var previews: some View {
        TabButton(title: "Bags", selectedTab: .constant("Bags"), animation: TabButton_Previews.animation)
    }
}
