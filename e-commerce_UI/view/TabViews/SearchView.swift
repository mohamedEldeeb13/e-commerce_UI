//
//  SearchView.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 20/01/2024.
//

import SwiftUI

struct SearchView: View {
    let customFont = "Raleway-Bold"
    var animation : Namespace.ID
    @FocusState var stateTF : Bool
    @EnvironmentObject var sharedData : SharedDataViewModel
    @EnvironmentObject var homeData : HomeViewModel
    var body: some View {
        VStack(spacing: 0)
        {
            HStack(spacing : 10)
            {
                Button {
                    withAnimation {
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundStyle(Color.black.opacity(0.7))
                }
                
                HStack(spacing: 15)
                {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundStyle(.gray)
                    TextField("Search", text: $homeData.searchText)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                        .focused($stateTF)
                }//: Hstack
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.vertical , 12)
                .padding(.horizontal)
                .background(Capsule().strokeBorder(Color("purple_color") , lineWidth: 1.5))
                .padding(.trailing , 20)
            }//: Hstack
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom,10)
            
            
            if let product = homeData.searchProduct {
                
                if product.isEmpty {
                    
                    VStack(spacing : 10)
                    {
                        Image("NotFound_2")
                            .resizable()
                            .scaledToFit()
                            .padding(.top,60)
                        
                        Text("item Not found")
                            .font(.custom(customFont, size: 22).bold())
                        Text("try more generic,search term or try looking for alternative products")
                            .font(.custom(customFont, size: 16))
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,30)
                    }
                    .padding()
                    .padding(.top,50)
                    
                }else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing : 0)
                        {
                            Text("Found \(product.count) results")
                                .font(.custom(customFont, size: 24).bold())
                                .padding(.vertical)
                            staggeredGrid(colums: 2,spacing: 20 ,list: product) { product in
                                productCardView(products: product)
                            }
                        }//: Vstack
                        .padding()
                    }//: scrollView
                    
                    
                }
            }else {
                ProgressView()
                    .padding(.top,30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
        }//: Vsatck
        .frame(maxWidth: .infinity,maxHeight: .infinity , alignment: .top)
        .background(Color("HomeBG").ignoresSafeArea())
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                stateTF = true
            }
        }
    }
    
    
//    @ViewBuilder
    func productCardView(products : product) -> some View {
        
        VStack(spacing: 10)
        {
            ZStack
            {
                if sharedData.showDetailsView {
                    Image(products.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                }else{
                    Image(products.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(products.id)SEARCH", in: animation)
                }
            }
            .background(Color.clear.cornerRadius(25))
            .offset(y: -50)
            .padding(.bottom, -50)
            Text(products.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(products.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundStyle(.gray)
            
            Text(products.price)
                .font(.custom(customFont, size: 16))
                .bold()
                .foregroundStyle(Color("purple_color"))
                .padding(.top , 5)
            
        }//: Vstack
        .padding(.horizontal , 20)
        .padding(.bottom , 22)
        .background(Color.white.cornerRadius(25))
        .padding(.top , 50)
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.fromSearchPage = true
                sharedData.detailsProduct = products
                sharedData.showDetailsView = true
            }
            
        }
        
        
    }
}

//#Preview {
//    SearchView().environmentObject(HomeViewModel())
//}
