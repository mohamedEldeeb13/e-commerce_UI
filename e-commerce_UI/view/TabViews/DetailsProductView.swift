//
//  DetailsProductView.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 20/01/2024.
//

import SwiftUI

struct DetailsProductView: View {
    let customFont = "Raleway-Bold"
    var product : product
    var animation : Namespace.ID
    @EnvironmentObject var sharedObject : SharedDataViewModel
    @EnvironmentObject var homeData : HomeViewModel
    var body: some View {
        VStack
        {
    //MARK: Header of Details view
            VStack
            {
                
                HStack
                {
                    Button {
                        //action back
                        withAnimation(.easeInOut) {
                            sharedObject.showDetailsView = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundStyle(Color.black.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image(systemName: "heart.fill")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .foregroundStyle( isLiked() ? Color.red : Color.black.opacity(0.7))
                        
                    }
                }//: Hstack
                .padding()
                
                // product image
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id:"\(product.id)\(sharedObject.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
                
            }//: second Vstack
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            
    //MARK: body of Details view (Product details)
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 15)
                {
                    Text(product.title)
                        .font(.custom(customFont, size: 22).bold())
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 18))
                        .foregroundStyle(Color.gray)
                    Text("Get Apple Tv+ free for a year")
                        .font(.custom(customFont, size: 16).bold())
                        .padding(.top)
                    Text("Available when you purchuse any new iphone, ipad, ipod Touch, Mac or Apple TV, $4.99/month after free trial.")
                        .font(.custom(customFont, size: 15))
                        .foregroundStyle(Color.gray)
                    
                    Button {
                        //action
                    } label: {
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full Description")
                        }
                        .font(.custom(customFont, size: 15).bold())
                        .foregroundStyle(Color("purple_color"))
                        
                    }
                    
                    HStack
                    {
                        Text("Total")
                            .font(.custom(customFont, size: 17))

                        Spacer()
                        
                        Text(product.price)
                            .font(.custom(customFont, size: 17).bold())
                            .foregroundStyle(Color("purple_color"))
                    }//: second Hstack
                    .padding(.vertical ,20)
                    
                    // basket buttom
                    
                    Button {
                        //action
                        addToCart()
                    } label: {
                        Text("\(isAddToCart() ? "Added" :"Add") to Basket")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundStyle(Color.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color("purple_color").cornerRadius(15)
                                    .shadow(color: .black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }


                    
                }//: thired Vstack
                .padding([.horizontal,.bottom],20)
                .padding(.top,25)
                .frame(maxWidth: .infinity, alignment:.leading)
            }//: scroll view
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color.white
                .clipShape(customCorner(corners: [.topLeft ,.topRight], radius: 25))
                .ignoresSafeArea()
            )
            .zIndex(0)
            
            
        }//: first Vstack
        .animation(.easeInOut , value: sharedObject.likedProduct)
        .animation(.easeInOut , value: sharedObject.cartProduct)
        .background(Color("HomeBG").ignoresSafeArea())
    }
    
    func isLiked() -> Bool {
        return sharedObject.likedProduct.contains { product in
            self.product.id == product.id
        }
    }
    func isAddToCart() -> Bool {
        return sharedObject.cartProduct.contains { product in
            self.product.id == product.id
        }
    }
    
    func addToLiked(){
        
        if let index = sharedObject.likedProduct.firstIndex(where: { product in
            return self.product.id == product.id
        }) {
            sharedObject.likedProduct.remove(at: index)
        }
        else{
            sharedObject.likedProduct.append(product)
        }
    }
    
    func addToCart(){
        
        if let index = sharedObject.cartProduct.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            sharedObject.cartProduct.remove(at: index)
        }
        else{
                sharedObject.cartProduct.append(product)
            }
        
    }
}

//#Preview {
//    DetailsProductView(product: HomeViewModel().products[0]).environmentObject(SharedDataViewModel())
////    LogInView()
//}
