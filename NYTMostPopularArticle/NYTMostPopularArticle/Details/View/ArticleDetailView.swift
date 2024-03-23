//
//  ArticleDetailView.swift
//  NYTimes
//
//  Created by ios on 22/03/2024.
//

import SwiftUI

struct ArticleDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var article: ArticleInfo
    @State  var showShareSheet = false
    var body: some View {
        VStack {
            CustomNavigationBar(
                title: "",
                leadingButtonImage: "chevron.left",
                leadingButtonAction: {
                    dismiss()
                },
                trailingButtonImage1: "eye",
                trailingButtonAction1: {
                    viewArticle()
                },
                trailingButtonImage2: "",
                trailingButtonAction2: {
                    
                })
            .overlay() {
                if let shareUrl = URL(string: article.url ?? "") {
                    ShareLink(item: shareUrl) {
                        Label("", systemImage: "square.and.arrow.up")
                            .foregroundColor(.white)
                    }
                    .offset(x: (UIScreen.main.bounds.width / 2) - 20 , y : -60)
                }
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let imageURL = article.media?.first?.mediaMetadata?.last?.url {
                        AsyncImage(url: URL(string: imageURL)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width , height: 200)
                                    .shadow(color: .gray, radius: 10)
                                
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width, height: 200)
                                
                            @unknown default:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width, height: 200)
                            }
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        DetailsView
                        
                    }
                    .padding(.horizontal, 10)
                    
                    
                }
                .padding()
                
            }
            .padding(.top, -90)
            Spacer()
                .sheet(isPresented: $showShareSheet) {
                    if let sharedURL = URL(string: self.article.url ?? "") {
                        ShareLink(item: sharedURL)
                    }
                    
                }
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    @ViewBuilder private var DetailsView: some View {
        Text("\(article.section ?? "")" + " - \(article.subsection ?? "")")
            .padding()
            .foregroundColor(.white)
            .fontWeight(.bold)
            .background(AppColors.primaryColor)
            .cornerRadius(10)
        
        
        Text(article.title ?? "")
            .font(.title)
            .fontWeight(.bold)
        if let keywords = article.adx_keywords {
            Text("#" + keywords.replacingOccurrences(of: ";", with: " #", options: .literal, range: nil))
                .font(.system(size: 12))
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.leading).padding(3)
        }
        Text(article.byline ?? "")
            .font(.subheadline)
            .foregroundColor(.gray)
        HStack( spacing: 10) {
            
            Text("Published On: ")
                .font(.system(size: 12, weight: .medium))  +
            Text("\(article.published_date ?? "")").font(.system(size: 12,weight: .medium))
                .foregroundColor(Color.gray)
            
            Text("Updated On: ") .font(.system(size: 12, weight: .medium))
            + (!((article.updated ?? "").isEmpty) ?
               Text("\(getdateValue(date: article.updated ?? "2012-04-23 24:12:12"))")
                .font(.system(size: 12))
                .foregroundColor(Color.gray) :
                Text(""))
        }
        .padding(.vertical, 5)
        Divider()
        Text("Abstract")
            .font(.headline)
        
        Text(article.abstract ?? "")
    }
    
    private func viewArticle() {
        if let url = URL(string: self.article.url ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    
    private func getAddKeyword(keywords: String) -> String {
        let newString = keywords.replacingOccurrences(of: ";", with: " #", options: .literal, range: nil)
        print(keywords, "\n", newString)
        return "#" + newString
    }
    
    private func getdateValue(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let  dateFromString = dateFormatter.date(from: date) else {
            return ""
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let datenew = dateFormatter.string(from: dateFromString)
        return datenew
    }
}

#Preview {
    ArticleDetailView(article: ArticleInfo(id: 1, title: "Title",section: "section", subsection: "subsection",  byline: "Bylinehjhhhhhhhhh hhhhhhhhhh hhhh", published_date: "2012-04-23 24:12:12", abstract: "vr", url: "https://static01.nyt.com/images/2024/03/19/multimedia/KRISTI-NOEM-STYLE-01-hbjm/KRISTI-NOEM-STYLE-01-hbjm-mediumThreeByTwo210.jpg", updated: "2024-03-20 22:58:47", media: [Media(mediaMetadata: [MediaMetadatum(url: "https://static01.nyt.com/images/2024/03/19/multimedia/KRISTI-NOEM-STYLE-01-hbjm/KRISTI-NOEM-STYLE-01-hbjm-mediumThreeByTwo210.jpg", format: "", height: 100, width: 100)])], adx_keywords: "d"))
}
