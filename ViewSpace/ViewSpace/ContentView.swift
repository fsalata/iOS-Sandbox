//
//  ContentView.swift
//  ViewSpace
//
//  Created by Fábio Salata on 23/10/20.
//

import SwiftUI

struct ContentView: View {
    @State var showDetail = false
    @Namespace private var viewSpace
    
    var body: some View {
        ZStack {
            VStack {
                ImageView(viewSpace: viewSpace)
                
                Button(action: {
                    withAnimation {
                        showDetail.toggle()
                    }
                }, label: {
                    Text("Tap")
                        .padding(.top, 20)
                })
            }
            
            if showDetail {
                DetailView(viewSpace: viewSpace)
            }
        }
    }
}

struct DetailView: View {
    var viewSpace: Namespace.ID
    
    var body: some View {
        VStack {
            ImageView(viewSpace: viewSpace)
            Spacer()
        }
    }
}

struct ImageView: View {
    var viewSpace: Namespace.ID
    
    var body: some View {
        Image(systemName: "cloud.bolt.fill")
            .font(.system(size: 80))
            .foregroundColor(.gray)
            .matchedGeometryEffect(id: "imageID", in: viewSpace, isSource: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
