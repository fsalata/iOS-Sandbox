//
//  BagView.swift
//  SwiftUIOnlineShop
//
//  Created by Fábio Salata on 27/10/20.
//

import SwiftUI

struct BagView: View {
    var bagData: BagModel
    var animation: Namespace.ID
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6, content: {
            ZStack {
                Color(bagData.image)
                    .cornerRadius(15)
                
                Image(bagData.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .matchedGeometryEffect(id: bagData.image, in: animation)
            }
            
            Text(bagData.title)
                .fontWeight(.heavy)
                .foregroundColor(.gray)
            
            Text(bagData.price)
                .fontWeight(.heavy)
                .foregroundColor(.black)
        })
    }
}

struct BagView_Previews: PreviewProvider {
    @Namespace static var anim
    
    static var previews: some View {
        BagView(bagData: bags[0], animation: BagView_Previews.anim)
    }
}
