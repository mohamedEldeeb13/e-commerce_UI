//
//  HomeView.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 18/01/2024.
//

import SwiftUI

struct HomeView: View {
    let customFont = "Raleway-Bold"
    var animation : Namespace.ID
    @EnvironmentObject var sharedData : SharedDataViewModel
    @StateObject var viewModel : HomeViewModel = HomeViewModel()
    var body: some View {
        ScrollView(.vertical ,showsIndicators: false) {
            VStack(spacing: 15)
            {
                //MARK: SearchBar
                ZStack
                {
                    if viewModel.searchActivated {
                        searchBar()
                    }else{
                        searchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        viewModel.searchActivated = true
                    }
                }
               
                
                //MARK: title page
                Text("Order online\ncollect in store")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity , alignment : .leading)
                    .padding(.top)
                    .padding(.horizontal , 25)
                
                
                //MARK: Products tab
                
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack(spacing: 16)
                    {
                        ForEach(productType.allCases , id : \.self){ item in
                            
                            ProductsTypeView(type: item)
                            
                        }
                    }//: Hstack
                    .padding(.horizontal, 25)
                        
                    
                }//: ScrollView
                .padding(.top , 25)
                
                //MARK: Products page
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 25)
                    {
                        ForEach(viewModel.filteredProduct , id : \.self){ product in
                            // product card view
                            productCardView(products: product)
                        }
                        
                    }//: Hstack
                    .padding(.horizontal,25)
                    .padding(.bottom)
                    .padding(.top,80)
                    
                }//: ScrollView
                .padding(.top,10)
                
                Button {
                    viewModel.showMoreProductView.toggle()
                } label: {
                    Label{
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("See More")
                    }
                    .font(.custom(customFont, size: 15).bold())
                    .foregroundStyle(Color("purple_color"))
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .padding(.trailing)
                    .padding(.top,10)
                }


                
            }//: Vstack
            .padding(.vertical)
        }//: ScrollView
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color("HomeBG"))
        .onChange(of: viewModel.productType) { oldValue, newValue in
            viewModel.filterProductByType()
        }
        .sheet(isPresented: $viewModel.showMoreProductView, content: {
            MoreProductView()
        })
        .overlay {
            ZStack
            {
                if viewModel.searchActivated {
                    SearchView(animation: animation)
                        .environmentObject(viewModel)
                }
            }
        }
    
    }
    
    // search bar
    @ViewBuilder
    func searchBar() -> some View {
        HStack(spacing: 15)
        {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundStyle(.gray)
            TextField("Search", text: .constant(""))
                .disabled(true)
        }//: Hstack
        .padding(.vertical , 12)
        .padding(.horizontal)
        .background(Capsule().strokeBorder(Color.gray , lineWidth: 0.8))
        
    }
    
    
    
    // product card view
    @ViewBuilder
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
                        .matchedGeometryEffect(id:"\(products.id)IMAGE", in: animation)
                }
                
            }//: Zstack
            .frame(width: getRect().width / 2.5, height: getRect().height / 3.5)
            .background(Color.clear.cornerRadius(25))
            .offset(y: -80)
            .padding(.bottom, -110)
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
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.detailsProduct = products
                sharedData.showDetailsView = true
            }
           
        }
        
        
        
    }
    
    @ViewBuilder
    func ProductsTypeView(type : productType) -> some View {
        Button
        {
            withAnimation {
                viewModel.productType = type
            }
            
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
                .foregroundStyle(viewModel.productType == type ? Color("purple_color") : Color.gray)
                .padding(.bottom, 10)
                .overlay (
                    ZStack
                    {
                        if viewModel.productType == type {
                            
                            Capsule().fill(Color("purple_color"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 3)
                        }else {
                            Capsule().fill(Color.clear)
                                .frame(height: 3)
                        }
                    }
                    ,alignment: .bottom
                )
        }
    }
}

//#Preview {
//    HomeView()
//}
