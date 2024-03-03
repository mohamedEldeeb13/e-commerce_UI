//
//  custom corner.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 18/01/2024.
//

import SwiftUI

struct customCorner : Shape {
    var corners : UIRectCorner
    var radius : CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect ,byRoundingCorners: corners ,cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
