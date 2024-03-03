//
//  CartView.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 22/01/2024.
//

import SwiftUI

struct CartView : View {
    let customFont = "Raleway-Bold"
    @EnvironmentObject var sharedData : SharedDataViewModel
    // delete option.....
    @State var showDeleteOtion : Bool = false
    var body: some View {
        NavigationView
        {
            VStack(spacing:10)
            {
                ScrollView(.vertical, showsIndicators: false)
                {
                    VStack
                    {
                        HStack
                        {
                            Text("Basket")
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
                            .opacity(sharedData.cartProduct.isEmpty ? 0:1)

                            
                        }//: Hstack
                        
                        //MARK: check if liked product are empty ?
                        
                        if sharedData.cartProduct.isEmpty {
                            
                            Group
                            {
                                Image("NoBasket1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                                    .padding(.top,30)
                                Text("No product added yet")
                                    .font(.custom(customFont, size: 25))
                                    .fontWeight(.semibold)
                                
                                Text("hit the plus buttom to save into basket.")
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
                                ForEach($sharedData.cartProduct){ $product in
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
                                        
                                        cardView(product : $product)
                                        
                                    }//: Hstack
                                }//: forEach
                                
                            }//: Vstack
                            .padding(.top,25)
                            .padding(.horizontal)
                           
                        }
                        
                    }//: Vstack
                    .padding()
                    
                }//: scrollView
                
                if !sharedData.cartProduct.isEmpty {
                    Group
                    {
                        HStack
                        {
                            Text("Total")
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundStyle(Color("purple_color"))

                        }
                        
                        Button {
                          // action
                        } label: {
                            Text("CheckOut")
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundStyle(Color.white)
                                .padding(.vertical,18)
                                .frame(maxWidth: .infinity)
                                .background(Color("purple_color"))
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
                        }
                        .padding(.vertical)

                    }//: Group
                    .padding(.horizontal,25)
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color("HomeBG").ignoresSafeArea())
            
        }//: NavigationView
    }
    
    
    func deleteProduct(product: product){
        
        if let index = sharedData.cartProduct.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
             let _ = withAnimation {
                sharedData.cartProduct.remove(at: index)
            }
          
        }
    }
}

#Preview {
    CartView()
        .environmentObject(SharedDataViewModel())
}

struct cardView :View {
    let customFont = "Raleway-Bold"
    @Binding var product : product
    var body: some View {
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
                // quantity buttons
                HStack(spacing: 10)
                {
                    Text("Quantity: ")
                        .font(.custom(customFont, size: 14))
                        .foregroundStyle(Color.gray)
                    Button {
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                        
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundStyle(Color.white)
                            .frame(width: 20, height: 20)
                            .background(Color("Quantity"))
                            .cornerRadius(4)
                    }
                    
                    Text("\(product.quantity)")
                        .font(.custom(customFont, size: 14))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.black)
                    
                    Button {
                        product.quantity += 1
                        
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundStyle(Color.white)
                            .frame(width: 20, height: 20)
                            .background(Color("Quantity"))
                            .cornerRadius(4)
                    }
                }

            }//: Vstack
            
        }//: Hstack
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(Color.white.cornerRadius(10))
    }
}
