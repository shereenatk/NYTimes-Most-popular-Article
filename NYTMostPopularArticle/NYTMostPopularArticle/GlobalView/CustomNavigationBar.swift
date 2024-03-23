//
//  CustomNavigationBar.swift
//  NYTimes
//
//  Created by ios on 22/03/2024.
//

import SwiftUI

struct CustomNavigationBar: View {
    var title: String
    var leadingButtonImage: String?
    var leadingButtonAction: (() -> Void)?
    var trailingButtonImage1: String?
    var trailingButtonAction1: (() -> Void)?
    var trailingButtonImage2: String?
    var trailingButtonAction2: (() -> Void)?
    
    var body: some View {
            VStack {
                HStack {
                    if let leadingImage = leadingButtonImage {
                        Button(action: {
                            leadingButtonAction?()
                        }) {
                            Image(systemName: leadingImage)
                                .foregroundColor(.white)
                        }
                        .tag("Leading Button")
                    }
                    
                    Spacer()
                    
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if let trailingImage1 = trailingButtonImage1 {
                        Button(action: {
                            trailingButtonAction1?()
                        }) {
                            Image(systemName: trailingImage1)
                                .foregroundColor(.white)
                        }
                    }
                    
                    if let trailingImage2 = trailingButtonImage2 {
                        Button(action: {
                            trailingButtonAction2?()
                        }) {
                            Image(systemName: trailingImage2)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(AppColors.primaryColor)
                
            }
            .frame(height: 130)
            .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    CustomNavigationBar(title: "NY Times")
}
