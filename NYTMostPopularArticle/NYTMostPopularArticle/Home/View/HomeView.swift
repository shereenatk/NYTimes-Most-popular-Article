//
//  HomeView.swift
//  NYTimes
//
//  Created by ios on 21/03/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ArticleViewModel =  ArticleViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                CustomNavigationBar(
                    title: "NY Times Most Popular",
                    leadingButtonImage: "line.horizontal.3",
                    leadingButtonAction: {
                        
                    },
                    trailingButtonImage1: "gear",
                    trailingButtonAction1: {
                    },
                    trailingButtonImage2: "bell",
                    trailingButtonAction2: {
                    })
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.articleList) { article in
                            NavigationLink(destination: ArticleDetailView(article: article)) {
                                ArticleRow(article: article)
                            }
                        }
                    }
                }
                .padding(.top, -100)
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.fetchArticles()
        }
    }
}

#Preview {
    HomeView()
}
