//
//  OnBoardingView.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 18/01/2024.
//

import SwiftUI

struct OnBoardingView: View {
    let customFont = "Raleway-Bold"
    @State var showingLoginPage = false
    var body: some View {
        VStack(alignment: .leading)
        {
            Text("Find your\nGadget")
                .font(.custom(customFont, size: 55))
                .foregroundStyle(.white)
                .fontWeight(.bold)
            Image("OnBoard")
                .resizable()
                .scaledToFit()
            Button {
                showingLoginPage = true
            } label: {
                Text("Get Start")
                    .font(.custom(customFont, size: 22))
                    .padding(.vertical , 17)
                    .frame(maxWidth: .infinity)
                    .fontWeight(.semibold)
                    .background(Color.white)
                    .foregroundStyle(Color("purple_color"))
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
            }
            .padding(.horizontal , 30)
            .offset(y : getRect().height < 750 ? 20 : 40)
            
            Spacer()
            
        }//: Vstack
        .padding()
        .padding(.top , getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity , maxHeight: .infinity)
        .background(Color("purple_color"))
        .overlay {
            if showingLoginPage {
                LogInView().transition(.move(edge: .bottom))
            }
        }
    }
}

#Preview {
    OnBoardingView()
        
    
        
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}


