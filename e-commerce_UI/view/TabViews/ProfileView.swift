//
//  ProfileView.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 20/01/2024.
//

import SwiftUI

struct ProfileView: View {
    let customFont = "Raleway-Bold"
    var body: some View {
        NavigationView
        {
            ScrollView(.vertical, showsIndicators: false)
            {
                VStack
                {
                    Text("My Profile")
                        .font(.custom(customFont, size: 22).bold())
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    VStack(spacing : 15)
                    {
                        Image("person_image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 60, height: 60, alignment: .center)
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        Text("Rosina Deo")
                            .font(.custom(customFont, size: 16))
                            .fontWeight(.semibold)
                        
                        HStack
                        {
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.degrees(180))
                            
                            Text("Address: 43 Oxford\nM13 4GR\nManchester,UK")
                                .font(.custom(customFont, size: 15))
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        
                    }//: second Vstack
                    .padding([.horizontal,.bottom])
                    .background(Color.white.clipShape(.rect(cornerRadius: 12)))
                    .padding()
                    .padding(.top ,40)
                    
                    // custom navigation link
                    customNavigationLink(title: "Edit Profile") {
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    customNavigationLink(title: "Shopping Address") {
                        Text("")
                            .navigationTitle("Shopping Address")
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    customNavigationLink(title: "Order history") {
                        Text("")
                            .navigationTitle("Order history")
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    customNavigationLink(title: "Cards") {
                        Text("")
                            .navigationTitle("Cards")
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    customNavigationLink(title: "Notifications") {
                        Text("")
                            .navigationTitle("Notifications")
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    
                    
                }//: first Vstack
                .padding(.horizontal , 22)
                .padding(.vertical, 20)
                
            }//: ScrollView
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color("HomeBG").ignoresSafeArea())
            
        }//: NavigationView
    }
    
    @ViewBuilder
    func customNavigationLink<Detail : View>(title : String , @ViewBuilder content :@escaping()->Detail) -> some View {
        NavigationLink {
            content()
        } label: {
            HStack
            {
                Text(title)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "chevron.right")
            }//: Hstack
            .foregroundStyle(.black)
            .padding()
            .background(Color.white.cornerRadius(12))
            .padding(.horizontal)
            .padding(.top,10)
        }

    }
    

}

#Preview {
    ProfileView()
}
