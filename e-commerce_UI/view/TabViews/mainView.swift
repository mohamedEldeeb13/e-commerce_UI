//
//  mainView.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 18/01/2024.
//

import SwiftUI

struct mainView: View {
    @State var currentTab : tab = .Home
    @StateObject var SharedData : SharedDataViewModel = SharedDataViewModel()
    @Namespace var animation
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack
        {
            TabView(selection: $currentTab,
                    content:  {
                HomeView(animation: animation)
                    .environmentObject(SharedData)
                    .tag(tab.Home)
               LikedView()
                    .environmentObject(SharedData)
                    .tag(tab.liked)
                ProfileView()
                    .tag(tab.profile)
                CartView()
                    .environmentObject(SharedData)
                    .tag(tab.cart)
                
            })
            
            
            HStack(spacing: 0)
            {
                ForEach(tab.allCases , id: \.self) { item in
                    Button(action: {
                        currentTab = item
                    }, label: {
                        Image(systemName: item.rawValue)
                            .resizable()
                            .scaledToFit()
                            .symbolRenderingMode(.hierarchical)
                            .frame(width: 22, height: 22)
                            .background(
                                Color("purple_color")
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currentTab == item ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == item ? Color("purple_color") : Color.black.opacity(0.3))
                    })
                    .padding([.horizontal , .top])
                    .padding(.bottom , 10)
                }
                
                
            }//: Hstack
            
            
        }//: Vstack
        .background(Color("HomeBG").ignoresSafeArea())
        .overlay {
            ZStack
            {
                if let product = SharedData.detailsProduct , SharedData.showDetailsView {
                    DetailsProductView(product: product, animation: animation)
                        .environmentObject(SharedData)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        }
    }
}

#Preview {
    mainView()
}


enum tab : String , CaseIterable {
    case Home = "house.fill"
    case liked = "suit.heart.fill"
    case profile = "person.fill"
    case cart = "cart.fill"
}
