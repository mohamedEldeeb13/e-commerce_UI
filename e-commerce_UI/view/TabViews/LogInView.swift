//
//  LogInView.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 18/01/2024.
//

import SwiftUI

struct LogInView: View {
    let customFont = "Raleway-Bold"
    @StateObject var viewModel = LogInViewModel()
    var body: some View {
        VStack
        {
            Text("Welcome\nBack")
                .font(.custom(customFont, size: 55).bold())
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
                .background(
                ZStack
                {
                    // LinearGraidaint circle
                    
                    LinearGradient(colors: [
                        Color("LoginCircle"),
                        Color("LoginCircle").opacity(0.8),
                        Color("purple_color")], startPoint: .top, endPoint: .bottom)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .offset(y: -25)
                    .padding(.trailing , 30)
                    .ignoresSafeArea()
                    
                    Circle()
                        .strokeBorder(.white.opacity(0.3) , lineWidth: 3)
                        .frame(width: 30, height: 30)
                        .blur(radius: 2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.leading,30)
                       
                    Circle()
                        .strokeBorder(.white.opacity(0.3) , lineWidth: 3)
                        .frame(width: 23, height: 23)
                        .blur(radius: 2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding(30)
                        
                        
                    
                })//: Zsatck
                
            ScrollView(.vertical ,showsIndicators: false) {
                
                // log in form ....
                VStack(spacing: 15)
                {
                    Text(viewModel.registerUser ? "Register" : "Login")
                        .font(.custom(customFont, size: 22).bold())
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    CustomTextField(icon: "envelope", title: "Email", hint: "Elmoo@gmail.com", value: $viewModel.email, showPassword: .constant(false))
                        .padding(.top, 30)
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "1234567", value: $viewModel.password, showPassword: $viewModel.showPassword)
                        .padding(.top, 10)
                    if viewModel.registerUser {
                        CustomTextField(icon: "lock", title: "Password", hint: "1234567", value: $viewModel.reEnterPasssword, showPassword: $viewModel.showReEnterPasssword)
                            .padding(.top, 10)
                    }
                    
                    // forget password buttom
                    if !viewModel.registerUser {
                        Button {
                            // forget Password
                            viewModel.forgetPassword()
                        } label: {
                            Text("Forget Password?")
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity ,alignment : .leading)
                                .foregroundColor(Color("purple_color"))
                        }
                        .padding(.top , 8)
                        
                    }
                    
                    // login buttom
                    Button {
                        // action
                        if viewModel.registerUser {
                            viewModel.logIn()
                        }else {
                            viewModel.register()
                        }
                    } label: {
                        Text(viewModel.registerUser ? "Register" : "Login")
                            .font(.custom(customFont, size: 22).bold())
                            .frame( maxWidth: .infinity)
                            .padding(.vertical , 20)
                            .foregroundStyle(Color.white)
                            .background(Color("purple_color"))
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.07), radius: 5, x: 5, y: 5)
                            
                    }
                    .padding(.top ,25)
                    .padding(.horizontal)
                    
                    
                    // swipe between login or register
                    Button {
                        // action
                        withAnimation {
                            viewModel.registerUser.toggle()
                        }
                    } label: {
                        Text(viewModel.registerUser ? "Back to login" : "Create account")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .frame( maxWidth: .infinity)
                            .foregroundStyle(Color("purple_color"))
                    }
                    .padding(.top ,8)
                    

                }//: second Vsatck
                .padding(30)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(customCorner(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
            

        }//: Vstack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("purple_color"))
        .onChange(of: viewModel.registerUser) { oldValue, newValue in
            viewModel.email = ""
            viewModel.password = ""
            viewModel.reEnterPasssword = ""
            viewModel.showPassword = false
            viewModel.showReEnterPasssword = false
        }
    }
    
    @ViewBuilder
    func CustomTextField(icon : String , title : String,hint : String , value : Binding<String> , showPassword : Binding<Bool>) -> some View {
        
        VStack(alignment: .leading, spacing: 12)
        {
            
            Label{
                Text(title)
                    .font(.custom(customFont, size: 14))
                    .foregroundStyle(Color.black.opacity(0.6))
                }
                icon: {
                    Image(systemName: icon)
                        .foregroundStyle(Color.black.opacity(0.6))
                }
                
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
                    .padding(.top , 2)
                
            }else {
                TextField(hint, text: value)
                    .padding(.top , 2)
                
            }
            
            Divider().background(.black.opacity(0.4))
        }
        .overlay(alignment: .trailing) {
            Group {
                if title.contains("Password") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundStyle(Color("purple_color"))
                    })
                    .offset(y: 8)
                }
            }
        }
        
    }
}

#Preview {
    LogInView()
}
