//
//  CustomCorner.swift
//  SwiftUIOnlineShop
//
//  Created by Fábio Salata on 27/10/20.
//

import SwiftUI

struct CustomCorner: Shape {
    func path(in rect: CGRect) -> Path {
        return Path(UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 35, height: 35)).cgPath)
    }
}
