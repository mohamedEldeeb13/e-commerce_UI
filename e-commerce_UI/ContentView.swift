//
//  ContentView.swift
//  e-commerce_UI
//
//  Created by Mohamed Abd Elhakam on 17/01/2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("Log_Status") var Log_Status : Bool = false
    var body: some View {
        Group
        {
            if Log_Status {
                mainView()
            }else {
                OnBoardingView()
            }
        }
       
    }
}

#Preview {
    ContentView()
}
