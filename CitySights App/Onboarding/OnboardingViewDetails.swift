//
//  OnBoardingViewDetails.swift
//  CitySights App
//
//  Created by Jonathan Guerrero on 7/20/25.
//

import SwiftUI

struct OnboardingViewDetails: View {
    
    var bgColor: Color
    var headline: String
    var subheadline: String
    var buttonAction: () -> Void
    
    var body: some View {
        ZStack {
            Color(bgColor)
            VStack (spacing: 0) {
                
                Spacer()
                Spacer()
                
                Image("onboarding")
                Text(headline)
                    .font(Font.system(size: 22))
                    .bold()
                    .padding(.top, 32)
                Text(subheadline)
                    .padding(.horizontal)
                    .padding(.top, 4)
                
                Spacer()
                
                Button {
                    buttonAction()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundStyle(Color.white)
                            .frame(height: 50)
                        Text("Continue")
                            .bold()
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 115)
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    OnboardingViewDetails(bgColor: Color(red: 111/255, green: 154/255, blue: 189/255), headline: "Welcome to CitySights!", subheadline: "City sights helps you find the best of the city!") {
        //Nothing
    }
}
