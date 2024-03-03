//
//  MoreProductView.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 19/01/2024.
//

import SwiftUI

struct MoreProductView: View {
    let customFont = "Raleway-Bold"
    var body: some View {
        VStack
        {
            Text("More Product ")
                .font(.custom(customFont, size: 24).bold())
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity,alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
        .background(Color("HomeBG").ignoresSafeArea())
        
    }
}

#Preview {
    MoreProductView()
}
