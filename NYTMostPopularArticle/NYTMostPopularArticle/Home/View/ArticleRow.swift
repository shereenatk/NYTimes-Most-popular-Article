//
//  ArticleRow.swift
//  NYTimes
//
//  Created by ios on 22/03/2024.
//

import SwiftUI

struct ArticleRow: View {
    let article: ArticleInfo
    
    var body: some View {
        HStack() {
            if let imageURL = article.media?.first?.mediaMetadata?.first?.url {
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .cornerRadius(40)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .cornerRadius(40)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 80, height: 80)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(40)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title ?? "")
                    .font(.headline)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                HStack {
                    Text(article.byline ?? "")
                        .font(.subheadline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                    Text(article.published_date ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

#Preview {
    ArticleRow(article: ArticleInfo(id: 1, title: "Title" ,section: "section", subsection: "subsection", byline: "Bylinehjhhhhhhhhh hhhhhhhhhh hhhh", published_date: "vcr", abstract: "vr", url: "fvr", updated: "", media: [Media(mediaMetadata: [MediaMetadatum(url: "https://static01.nyt.com/images/2024/03/19/multimedia/KRISTI-NOEM-STYLE-01-hbjm/KRISTI-NOEM-STYLE-01-hbjm-mediumThreeByTwo210.jpg", format: "", height: 100, width: 100)])], adx_keywords: "d"))
    
}
