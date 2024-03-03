//
//  LikedView.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 21/01/2024.
//

import SwiftUI

struct LikedView: View {
    let customFont = "Raleway-Bold"
    @EnvironmentObject var sharedData : SharedDataViewModel
    // delete option.....
    @State var showDeleteOtion : Bool = false
    var body: some View {
        NavigationView
        {
            ScrollView(.vertical, showsIndicators: false)
            {
                VStack
                {
                    HStack
                    {
                        Text("Favorite")
                            .font(.custom(customFont, size: 28).bold())
                            
                        Spacer()
                        
                        Button {
                            //action
                            withAnimation {
                                showDeleteOtion.toggle()
                            }
                            
                        } label: {
                            Image("delete2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 23, height: 23)
                        }
                        .opacity(sharedData.likedProduct.isEmpty ? 0:1)

                        
                    }//: Hstack
                    
                    //MARK: check if liked product are empty ?
                    
                    if sharedData.likedProduct.isEmpty {
                        
                        Group
                        {
                            Image("NoLiked")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top,30)
                            Text("No favorite yet")
                                .font(.custom(customFont, size: 25))
                                .fontWeight(.semibold)
                            
                            Text("hit the like buttom in each product page to save favorite ones.")
                                .font(.custom(customFont, size: 18))
                                .foregroundStyle(Color.gray)
                                .padding(.horizontal)
                                .padding(.top,10)
                                .multilineTextAlignment(.center)
                            
                        }
                        
                    }else{
                        // display products
                        VStack(spacing: 15)
                        {
                            ForEach(sharedData.likedProduct){ product in
                                HStack(spacing: 0)
                                {
                                    if showDeleteOtion {
                                        
                                        Button {
                                            //ation
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundStyle(Color.red)
                                                
                                        }
                                        .padding(.trailing)
                                    }
                                    
                                    cardView(product: product)
                                    
                                }//: Hstack
                            }//: forEach
                            
                        }//: Vstack
                        .padding(.top,25)
                        .padding(.horizontal)
                       
                    }
                    
                }//: Vstack
                .padding()
                
            }//: scrollView
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color("HomeBG").ignoresSafeArea())
            
        }//: NavigationView
    }
    
    
    @ViewBuilder
    func cardView(product : product) -> some View {
        
        HStack(spacing: 15)
        {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100,height: 100)
            
            VStack(alignment: .leading,spacing: 8)
            {
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                Text(product.title)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("purple_color"))
                Text("Type:\(product.type.rawValue)")
                    .font(.custom(customFont, size: 13))
                    .foregroundStyle(Color.gray)
            }//: Vstack
            
        }//: Hstack
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(Color.white.cornerRadius(10))
        
    }
    func deleteProduct(product : product){
        
        if let index = sharedData.likedProduct.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
            let _ = withAnimation {
                sharedData.likedProduct.remove(at: index)
            }
          
        }
        
    }
}

#Preview {
    LikedView().environmentObject(SharedDataViewModel())
}
