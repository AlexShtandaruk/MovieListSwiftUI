//
//  ContentView.swift
//  astonMovieListSwiftUI
//
//  Created by Alex Shtandaruk on 18.06.2023.
//

import SwiftUI

struct ContentView: View {
    
    //log status
    @AppStorage("logStatus") var logStatus: Bool = false
    
    var body: some View {
        Group {
            if logStatus {
                MainPage()
            } else {
                OnBoardingPage()
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
