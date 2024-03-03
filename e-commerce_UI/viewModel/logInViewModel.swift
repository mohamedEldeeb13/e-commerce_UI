//
//  logInViewModel.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 18/01/2024.
//

import SwiftUI


class LogInViewModel : ObservableObject {
    //: login attribute
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var showPassword : Bool = false
    @AppStorage("Log_Status") var Log_Status : Bool = false
    
    //: register attribute
    @Published var registerUser : Bool = false
    @Published var reEnterPasssword : String = ""
    @Published var showReEnterPasssword : Bool = false
    
    
    
    
    func logIn(){
        withAnimation {
            Log_Status = true
        }
    }
    func register(){
        withAnimation {
            Log_Status = true
        }
    }
    func forgetPassword(){}
}
