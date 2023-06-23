//
//  OnBoardingPage.swift
//  astonMovieListSwiftUI
//
//  Created by Alex Shtandaruk on 18.06.2023.
//

import SwiftUI

// to use custom font on all pages
let customFont = "Raleway-Regular"

struct OnBoardingPage: View {
    
    //show login page
    @State var showLoginPage: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Find your\nfilm")
                .font(.custom(customFont, size: 55))
            //since we added all three fonts in info.plist we can call all of those fonts with any names
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Image("onBoarding")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button(action: { showLoginPage = true }) {
                Text("Get started")
                    .font(.custom(customFont, size: 20))
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(.indigo)
            }
            .padding(.horizontal, 20)
            //adding some adjustment only for larger displays§
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()
        }
        .padding()
        .padding(.top, getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.indigo)
        .toolbar(.hidden, for: .tabBar)
        .overlay(
            Group {
                if showLoginPage {
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
        
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
